//
//  DisableAdsPurchaseCoordinator.swift
//  MacroCosm
//
//  Created by Антон Текутов on 21.05.2021.
//

import UIKit

final class DisableAdsPurchaseCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableDisableAdsPurchaseViewModel) -> Void)? = nil) -> UIViewController {
        let view = DisableAdsPurchaseViewController()
        let viewModel = DisableAdsPurchaseViewModel()
        let coordinator = DisableAdsPurchaseCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view

        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view
extension DisableAdsPurchaseCoordinator: DisableAdsPurchaseCoordinatorProtocol {

}