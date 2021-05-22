//
//  SettingsCoordinator.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class SettingsCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableSettingsViewModel) -> Void)? = nil) -> UIViewController {
        let view = SettingsViewController()
        let viewModel = SettingsViewModel()
        let coordinator = SettingsCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view

        viewModel.purchaseManager = PurchaseManager.shared
        
        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view
extension SettingsCoordinator: SettingsCoordinatorProtocol {

}
