//
//  SettingsViewModel.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import Foundation
import StoreKit

final class SettingsViewModel {
	var output: SettingsOutput?
    
    var purchaseManager: PurchaseManagerProtocol!

}

// MARK: - Configuration
extension SettingsViewModel: CustomizableSettingsViewModel {

}

// MARK: - Interface for view
extension SettingsViewModel: SettingsViewModelProtocol {

    var termsOfUsageUrl: URL? {
        return purchaseManager.termsOfUsageUrl
    }
    var privacyPolicyUrl: URL? {
        return purchaseManager.privacyPolicyUrl
    }
    var supportUrl: URL? {
        return purchaseManager.supportUrl
    }
    
    func rateApp() {
        purchaseManager.rateApp()
    }
    
    func checkPurchaseStatus(_ completionHandler: @escaping(PurchaseVerification) -> Void) {
        purchaseManager.checkActivePurchase { result in
            switch result {
            case .success(let isActive):
                completionHandler(isActive)
                
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.notPurchased)
            }
        }
    }
    
    func restorePurchases(_ callback: @escaping RestorePurchasesCompletion) {
        purchaseManager.restorePurchases(callback)
    }
}

