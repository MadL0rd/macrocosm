//
//  TodayViewModel.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import Foundation

final class TodayViewModel {
	var output: TodayOutput?
    
    var horoscopeService: HoroscopeNetworkServiceProtocol!
    var adMobService: AdMobServiceProtocol!
    var purchaseManager: PurchaseManagerProtocol!
    var userInfoStorage: UserInfoStorageServiceProtocol! {
        didSet {
            userInfoStorage.subscribe(self)
        }
    }
    
    var zodiacPredictionWillChange: (() -> Void)?
    var zodiacPredictionDidChanged: ((ZodiacPrediction) -> Void)?
}

// MARK: - Configuration
extension TodayViewModel: CustomizableTodayViewModel {

}

// MARK: - Interface for view
extension TodayViewModel: TodayViewModelProtocol {
    
    func loadData() {
        guard let zodiacId = userInfoStorage.userInfo.zodiacIndex
        else { return }
        
        zodiacPredictionWillChange?()
        
        horoscopeService.getDaylyPrediction(zodiacId: zodiacId) { [ weak self ] result in
            guard let self = self
            else { return }
            
            switch result {
            case .success(let data):
                self.zodiacPredictionDidChanged?(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showRewardedAd(_ completion: @escaping ShowFullscreenRewardedAdCompletion) {
        adMobService.showFullscreenRewardedAd(completion)
    }
    
    func canShowContentCheck(_ completion: @escaping(Bool) -> Void) {
        purchaseManager.checkActivePurchase { [ weak self ] result in
            switch result {
            case .success(let isActive):
                if isActive == .active {
                    completion(true)
                    return
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            self?.canShowContentDateCheck(completion)
        }
    }
    
    private func canShowContentDateCheck(_ completion: @escaping(Bool) -> Void) {
        guard let date = userInfoStorage.lastAdsWatchDate
        else {
            resetAdsWatchDate()
            completion(true)
            return
        }
        
        horoscopeService.getDate { result in
            switch result {
            case .success(let data):
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = Contacts.defaultDateFormat
                
                let dateString = String(data.serverTime.prefix(19))
                
                guard let dateServer = dateFormatter.date(from: dateString),
                      let weeksCountServer = Calendar.current.dateComponents([.weekOfYear], from: dateServer).weekOfYear,
                      let weeksCountLocal = Calendar.current.dateComponents([.weekOfYear], from: date).weekOfYear
                else {
                    completion(false)
                    return
                }
                
                completion(weeksCountServer == weeksCountLocal)
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func resetAdsWatchDate() {
        horoscopeService.getDate { [ weak self ] result in
            switch result {
            case .success(let data):
                let dateString = String(data.serverTime.prefix(19))
                self?.userInfoStorage.saveDate(dateString)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Interface for view
extension TodayViewModel: UserInfoStorageServiceSubscriber {
    
    func needToReloadBorders() {
        loadData()
    }
}

