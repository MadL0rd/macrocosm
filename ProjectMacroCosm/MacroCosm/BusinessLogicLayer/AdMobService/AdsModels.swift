//
//  AdsModels.swift
//  MacroCosm
//
//  Created by Антон Текутов on 22.05.2021.
//

import GoogleMobileAds

struct FullscreenRewardedAd {
    
    let ad: GADRewardedAd
}

enum AdMobServiceError: Error {
    
    case failToLoadAds
    case failToPresentAds
    case userCloseAd
}

typealias LoadFullscreenRewardedAdCompletion = (Result<FullscreenRewardedAd, AdMobServiceError>) -> Void
typealias ShowFullscreenRewardedAdCompletion = (Result<Void, AdMobServiceError>) -> Void
