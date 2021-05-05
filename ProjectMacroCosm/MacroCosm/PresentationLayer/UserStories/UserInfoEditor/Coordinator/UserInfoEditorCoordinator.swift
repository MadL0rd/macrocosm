//
//  UserInfoEditorCoordinator.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class UserInfoEditorCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableUserInfoEditorViewModel) -> Void)? = nil) -> UIViewController {
        let view = UserInfoEditorViewController()
        let viewModel = UserInfoEditorViewModel()
        let coordinator = UserInfoEditorCoordinator()

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
extension UserInfoEditorCoordinator: UserInfoEditorCoordinatorProtocol {

    func showMainScreen() {
        let vc = MainCoordinator.createModule()
        transition.presentInNewRootNavigationStack(controller: vc, animated: true, completionHandler: nil)
    }
}
