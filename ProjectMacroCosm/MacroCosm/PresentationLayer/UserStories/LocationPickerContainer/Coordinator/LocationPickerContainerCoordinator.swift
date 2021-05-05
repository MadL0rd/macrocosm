//
//  LocationPickerContainerCoordinator.swift
//  MacroCosm
//
//  Created by Антон Текутов on 01.04.2021.
//

import UIKit

final class LocationPickerContainerCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableLocationPickerContainerViewModel) -> Void)? = nil) -> UIViewController {
        let view = LocationPickerContainerViewController()
        let viewModel = LocationPickerContainerViewModel()
        let coordinator = LocationPickerContainerCoordinator()

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
extension LocationPickerContainerCoordinator: LocationPickerContainerCoordinatorProtocol {

}