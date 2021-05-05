//
//  MainViewModel.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

final class MainViewModel {
	var output: MainOutput?
}

// MARK: - Configuration
extension MainViewModel: CustomizableMainViewModel {

}

// MARK: - Interface for view
extension MainViewModel: MainViewModelProtocol {

}

