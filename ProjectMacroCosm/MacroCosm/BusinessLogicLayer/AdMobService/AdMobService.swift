//
//  AdMobService.swift
//  MacroCosm
//
//  Created by Антон Текутов on 21.05.2021.
//

import GoogleMobileAds

fileprivate enum AdUnitID: String {
    
    case rewardedAdTest = "ca-app-pub-3940256099942544/1712485313"
    case rewardedAdProduction = "ca-app-pub-8367677710498385/6952606680"
}

class AdMobService: NSObject, AdMobServiceProtocol {
    
    static let shared: AdMobServiceProtocol = AdMobService()
    
    private var fullscreenRewardedAdBuff: FullscreenRewardedAd?
    private var showFullscreenRewardedAdCompletion: ShowFullscreenRewardedAdCompletion?
    
    func startConfiguration() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    func loadFullscreenRewardedAd(_ completion: @escaping LoadFullscreenRewardedAdCompletion) {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: AdUnitID.rewardedAdProduction.rawValue,
                           request: request) { [ weak self ] ad, error in
            guard error == nil,
                  let ad = ad
            else {
                completion(.failure(.failToLoadAds))
                return
            }
            ad.fullScreenContentDelegate = self
            completion(.success(FullscreenRewardedAd(ad: ad)))
        }
    }
    
    func showFullscreenRewardedAd(_ completion: @escaping ShowFullscreenRewardedAdCompletion) {
        showFullscreenRewardedAdCompletion = completion
        loadFullscreenRewardedAd { [ weak self ] result in
            guard let self = self
            else { return }
            
            switch result {
            case .success(let data):
                self.fullscreenRewardedAdBuff = data
                data.ad.present(fromRootViewController: UIApplication.shared.keyWindow!.rootViewController!) {
                    self.fullscreenRewardedAdBuff = nil
                    self.showFullscreenRewardedAdCompletion = nil

                    completion(.success(()))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - GADFullScreenContentDelegate

extension AdMobService: GADFullScreenContentDelegate {
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        showFullscreenRewardedAdCompletion?(.failure(.failToPresentAds))
    }
    
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        showFullscreenRewardedAdCompletion?(.failure(.userCloseAd))
    }
}
