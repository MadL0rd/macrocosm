//
//  DisableAdsPurchaseViewModel.swift
//  MacroCosm
//
//  Created by Антон Текутов on 21.05.2021.
//

import StoreKit

final class DisableAdsPurchaseViewModel {
	var output: DisableAdsPurchaseOutput?
    
    var purchaseManager: PurchaseManagerProtocol!
    
    private var product: SKProduct?
}

// MARK: - Configuration
extension DisableAdsPurchaseViewModel: CustomizableDisableAdsPurchaseViewModel {

}

// MARK: - Interface for view
extension DisableAdsPurchaseViewModel: DisableAdsPurchaseViewModelProtocol {

    func loadPurchasePrice(_ completion: @escaping(String) -> Void) {
        purchaseManager.getProductInfo(.disableAds) { [ weak self ] product in
            guard let self = self
            else { return }
            self.product = product
            completion(product.localizedPrice)
        }
    }
    
    func buyDisableAdsPurchase(callback: @escaping(Bool) -> Void) {
        purchaseManager.purchaseProduct(.disableAds) { result in
            switch result {
            case .success(let isActive):
                if isActive == .active {
                    callback(true)
                    return
                }
            case .failure(let error):
                print(error)
            }
            callback(false)
        }
    }
}

