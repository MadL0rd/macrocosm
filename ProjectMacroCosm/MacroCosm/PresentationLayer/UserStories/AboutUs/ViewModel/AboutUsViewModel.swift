//
//  AboutUsViewModel.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

final class AboutUsViewModel {
	var output: AboutUsOutput?
}

// MARK: - Configuration
extension AboutUsViewModel: CustomizableAboutUsViewModel {

}

// MARK: - Interface for view
extension AboutUsViewModel: AboutUsViewModelProtocol {

}

