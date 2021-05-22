//
//  PurchaseManagerProtocol.swift
//  MacroCosm
//
//  Created by Антон Текутов on 22.05.2021.
//

import SwiftyStoreKit
import StoreKit

protocol PurchaseManagerProtocol: AnyObject {
    
    var termsOfUsageUrl: URL? { get }
    var privacyPolicyUrl: URL? { get }
    var supportUrl: URL? { get }
    
    func completeTransactions()
    func checkActivePurchase(_ callback: @escaping CheckActivePurchasesCompletion)
    func getProductInfo(_ productId: PurchaseId, callback: @escaping GetPurchaseInfoCompletion)
    func purchaseProduct(_ productId: PurchaseId, callback: @escaping CheckActivePurchasesCompletion)
    func purchaseProduct(_ productId: SKProduct, callback: @escaping CheckActivePurchasesCompletion)
    func restorePurchases(_ callback: @escaping RestorePurchasesCompletion)
    func rateApp()
    
    func forceSetSubscriptionActive()
}
