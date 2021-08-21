//
//  PurchaseManager.swift
//  MacroCosm
//
//  Created by Антон Текутов on 22.05.2021.
//

import SwiftyStoreKit
import StoreKit

class PurchaseManager: PurchaseManagerProtocol {
    
    static let shared: PurchaseManagerProtocol = PurchaseManager()
    
    private var sharedSecret: String { LocalOnlyConstants.sharedSecret }
    
    var termsOfUsageUrl: URL? {
        return URL(string: "https://docs.macrocosm.cherrydev.tech/TermsOfUsage.html")
    }
    var privacyPolicyUrl: URL? {
        return URL(string: "https://docs.macrocosm.cherrydev.tech/PrivacyPolicy.html")
    }
    
    var supportUrl: URL? {
        return URL(string: "https://www.facebook.com/macrocosmos11111")
    }
    
    var purchaseIsActive: PurchaseVerification?
    
    func completeTransactions() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                print(purchase)
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                @unknown default:
                    break
                }
            }
        }
    }
    
    func checkActivePurchase(_ callback: @escaping CheckActivePurchasesCompletion) {
        guard purchaseIsActive != .active
        else {
            callback(.success(.active))
            return
        }
        
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { [ weak self ] result in
            switch result {
            case .success(let receipt):
                let productId = PurchaseId.disableAds.rawValue
                // Verify the purchase of Consumable or NonConsumable
                let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: productId, inReceipt: receipt)
                
                switch purchaseResult {
                case .purchased(let receiptItem):
                    print("\(productId) is purchased: \(receiptItem)")
                    self?.purchaseIsActive = .active
                    callback(.success(.active))

                case .notPurchased:
                    print("The user has never purchased \(productId)")
                    self?.purchaseIsActive = .notPurchased
                    callback(.success(.notPurchased))
                }
                
            case .error(let error):
                print("Receipt verification failed: \(error)")
                callback(.failure(error))
            }
        }
    }
    
    func getProductInfo(_ productId: PurchaseId, callback: @escaping GetPurchaseInfoCompletion) {
        SwiftyStoreKit.retrieveProductsInfo([productId.rawValue]) { result in
            guard let product = result.retrievedProducts.first
            else { return }
            callback(product)
        }
    }
    
    func purchaseProduct(_ productId: PurchaseId, callback: @escaping CheckActivePurchasesCompletion) {
        getProductInfo(productId) { [ weak self ] product in
            self?.purchaseProduct(product, callback: callback)
        }
    }
    
    func purchaseProduct(_ product: SKProduct, callback: @escaping CheckActivePurchasesCompletion) {
        SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                callback(.success(purchase.needsFinishTransaction ? .notPurchased : .active))
                
            case .error(let error):
                print("Receipt verification failed: \(error)")
                callback(.failure(error))
                
            }
        }
    }
    
    func restorePurchases(_ callback: @escaping RestorePurchasesCompletion) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if !results.restoreFailedPurchases.isEmpty {
                return callback(.failed)
            }
            if !results.restoredPurchases.isEmpty {
                return callback(.success)
            }
            return callback(.nothingToRestore)
        }
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
    
    func forceSetSubscriptionActive() {
        purchaseIsActive = .active
    }
}
