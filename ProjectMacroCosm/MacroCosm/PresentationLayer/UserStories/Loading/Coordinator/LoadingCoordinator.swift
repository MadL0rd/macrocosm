//
//  LoadingCoordinator.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.21.
//

import UIKit

final class LoadingCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableLoadingViewModel) -> Void)? = nil) -> UIViewController {
        let view = LoadingViewController()
        let viewModel = LoadingViewModel()
        let coordinator = LoadingCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view
        
        viewModel.userInfoStorage = UserInfoStorageService.shared

        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view
extension LoadingCoordinator: LoadingCoordinatorProtocol {
    
    func showMainScreen() {
        let vc = MainCoordinator.createModule()
        transition.presentInNewRootNavigationStack(controller: vc, animated: true, completionHandler: nil)
    }
    
    func showUserInfoEditor() {
        let vc = UserInfoEditorCoordinator.createModule()
        transition.presentInNewRootNavigationStack(controller: vc, animated: true, completionHandler: nil)
    }
}
