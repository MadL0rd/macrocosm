//
//  AdMobServiceProtocol.swift
//  MacroCosm
//
//  Created by Антон Текутов on 21.05.2021.
//

import GoogleMobileAds

protocol AdMobServiceProtocol: AnyObject {
    
    func startConfiguration()
    func loadFullscreenRewardedAd(_ completion: @escaping LoadFullscreenRewardedAdCompletion)
    func showFullscreenRewardedAd(_ completion: @escaping ShowFullscreenRewardedAdCompletion)
}
