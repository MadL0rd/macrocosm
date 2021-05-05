//
//  MainCoordinator.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class MainCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableMainViewModel) -> Void)? = nil) -> UIViewController {
        let view = MainViewController()
        let viewModel = MainViewModel()
        let coordinator = MainCoordinator()

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
extension MainCoordinator: MainCoordinatorProtocol {
    
    func generateTodayModule() -> UIViewController {
        return TodayCoordinator.createModule()
    }
    
    func generateGeneralModule() -> UIViewController {
        return GeneralCoordinator.createModule()
    }
}
