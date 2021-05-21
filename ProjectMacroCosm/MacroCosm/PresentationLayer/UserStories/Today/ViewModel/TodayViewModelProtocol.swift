//
//  TodayViewModelProtocol.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

protocol TodayViewModelProtocol: AnyObject {
    
    // needs to reload data when user change info in settings
    var zodiacPredictionWillChange: (() -> Void)? { get set }
    var zodiacPredictionDidChanged: ((ZodiacPrediction) -> Void)? { get set }

    func loadData()
    func showRewardedAd(_ completion: @escaping ShowFullscreenRewardedAdCompletion)
    func canShowContentCheck(_ completion: @escaping(Bool) -> Void)
    func resetAdsWatchDate()
}
