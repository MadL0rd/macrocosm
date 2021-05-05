//
//  GeneralViewModel.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

final class GeneralViewModel {
    var output: GeneralOutput?
    
    var horoscopeService: HoroscopeNetworkServiceProtocol!
    var userInfoStorage: UserInfoStorageServiceProtocol! {
        didSet {
            userInfoStorage.subscribe(self)
        }
    }
    
    var zodiacPredictionWillChange: (() -> Void)?
    var zodiacPredictionDidChanged: ((ZodiacPrediction) -> Void)?
}

// MARK: - Configuration
extension GeneralViewModel: CustomizableGeneralViewModel {
    
}

// MARK: - Interface for view
extension GeneralViewModel: GeneralViewModelProtocol {
    
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
}

// MARK: - Interface for view
extension GeneralViewModel: UserInfoStorageServiceSubscriber {
    
    func needToReloadBorders() {
        loadData()
    }
}
