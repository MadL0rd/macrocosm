//
//  UserInfoEditorViewModel.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

final class UserInfoEditorViewModel {
	var output: UserInfoEditorOutput?
    
    var userInfoStorage: UserInfoStorageServiceProtocol!
    
    var userInfo: UserInfo {
        get { userInfoStorage.userInfo }
        set { userInfoStorage.userInfo = newValue }
    }
}

// MARK: - Configuration
extension UserInfoEditorViewModel: CustomizableUserInfoEditorViewModel {

}

// MARK: - Interface for view
extension UserInfoEditorViewModel: UserInfoEditorViewModelProtocol {
    
}

