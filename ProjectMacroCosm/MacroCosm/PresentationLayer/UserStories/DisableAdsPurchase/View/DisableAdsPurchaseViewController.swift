//
//  DisableAdsPurchaseViewController.swift
//  MacroCosm
//
//  Created by Антон Текутов on 21.05.2021.
//

import UIKit

final class DisableAdsPurchaseViewController: AlertPresentationViewController {
    
    var viewModel: DisableAdsPurchaseViewModelProtocol!
    var coordinator: DisableAdsPurchaseCoordinatorProtocol!
    
    private var _view: DisableAdsPurchaseView {
        return view as! DisableAdsPurchaseView
    }
    
    override func loadView() {
        self.view = DisableAdsPurchaseView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSelf()
    }
    
    private func configureSelf() {
        _view.buyButton.addTarget(self, action: #selector(disableAdsPurchase), for: .touchUpInside)
        
        viewModel.loadPurchasePrice { [ weak self ] price in
            self?._view.priceLabel.text = price
        }
    }
    
    // MARK: - UI elements actions
    
    @objc private func disableAdsPurchase() {
        let loadingHUD = AlertManager.getLoadingHUD(on: _view)
        loadingHUD.show(in: _view)
        
        viewModel.buyDisableAdsPurchase { [ weak self ] success in
            guard let self = self
            else { return }
            loadingHUD.dismiss()
            
            if success {
                AlertManager.showSuccessHUD(on: self.view)
                self.dismissThisController()
            } else {
                AlertManager.showErrorHUD(on: self.view)
            }
        }
    }
}
