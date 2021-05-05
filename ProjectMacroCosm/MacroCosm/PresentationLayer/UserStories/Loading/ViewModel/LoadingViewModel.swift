//
//  LoadingViewModel.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.21.
//

final class LoadingViewModel {
    
	var output: LoadingOutput?
    
    var userInfoStorage: UserInfoStorageServiceProtocol!
    
    var userInfo: UserInfo {
        return userInfoStorage.userInfo
    }
}

// MARK: - Configuration
extension LoadingViewModel: CustomizableLoadingViewModel {

}

// MARK: - Interface for view
extension LoadingViewModel: LoadingViewModelProtocol {
    
    func startConfiguration() {
        
    }
}

