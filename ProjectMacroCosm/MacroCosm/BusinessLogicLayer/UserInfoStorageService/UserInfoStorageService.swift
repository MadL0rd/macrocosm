//
//  UserInfoStorageService.swift
//  MacroCosm
//
//  Created by Антон Текутов on 01.04.2021.
//

import Foundation

fileprivate enum DefaultsKeys: String {
    case totalObject
    case date
    case time
    case location
}

@objc protocol UserInfoStorageServiceSubscriber: AnyObject {
    
    func needToReloadBorders()
}

class UserInfoStorageService: UserInfoStorageServiceProtocol {
    
    static let shared: UserInfoStorageServiceProtocol = UserInfoStorageService()
    
    var subscribers = [Weak<UserInfoStorageServiceSubscriber>]()
    
    var userInfo: UserInfo {
        get { getUserInfo() }
        set { saveUserInfo(newValue) }
    }
    
    func subscribe(_ subscriber: UserInfoStorageServiceSubscriber) {
        subscribers.reap()
        subscribers.append(Weak(value: subscriber))
    }
    
    func needToReloadData() {
        subscribers.reap()
        for subscriber in subscribers {
            subscriber.value?.needToReloadBorders()
        }
    }
    
    private func saveUserInfo(_ info: UserInfo) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(info) {
            UserDefaults.standard.set(encoded, forKey: DefaultsKeys.totalObject.rawValue)
        }
        needToReloadData()
    }
    
    private func getUserInfo() -> UserInfo {
        let decoder = JSONDecoder()
        guard let savedUserInfo = UserDefaults.standard.object(forKey: DefaultsKeys.totalObject.rawValue) as? Data,
              let info = try? decoder.decode(UserInfo.self, from: savedUserInfo)
        else {
            let info = UserInfo()
            saveUserInfo(info)
            return info
        }
        
        return info
    }
}

extension Array where Element: Weak<UserInfoStorageServiceSubscriber> {
    
    mutating func reap() {
        self = self.filter { nil != $0.value }
    }
}
