//
//  SettingsViewModel.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import Foundation
import StoreKit

final class SettingsViewModel {
	var output: SettingsOutput?
}

// MARK: - Configuration
extension SettingsViewModel: CustomizableSettingsViewModel {

}

// MARK: - Interface for view
extension SettingsViewModel: SettingsViewModelProtocol {

    var termsOfUsageUrl: URL? {
        return URL(string: "http://80.78.247.50:8008/media/TermsConditions.html")
    }
    var privacyPolicyUrl: URL? {
        return URL(string: "http://80.78.247.50:8008/media/PrivacyPolicy.html")
    }
    var supportUrl: URL? {
        return URL(string: "https://vk.com/clubhouseborderedavatar")
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
}

