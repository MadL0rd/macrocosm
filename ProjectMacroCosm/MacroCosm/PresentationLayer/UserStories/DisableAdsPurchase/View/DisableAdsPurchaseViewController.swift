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
        
    }
}