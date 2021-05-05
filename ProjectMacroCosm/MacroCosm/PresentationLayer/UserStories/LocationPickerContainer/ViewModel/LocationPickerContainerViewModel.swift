//
//  LocationPickerContainerViewModel.swift
//  MacroCosm
//
//  Created by Антон Текутов on 01.04.2021.
//

final class LocationPickerContainerViewModel {
	var output: LocationPickerContainerOutput?
}

// MARK: - Configuration
extension LocationPickerContainerViewModel: CustomizableLocationPickerContainerViewModel {

}

// MARK: - Interface for view
extension LocationPickerContainerViewModel: LocationPickerContainerViewModelProtocol {

}

