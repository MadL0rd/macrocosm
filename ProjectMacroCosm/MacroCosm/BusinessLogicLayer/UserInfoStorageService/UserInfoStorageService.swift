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
    
    private let secureStorrage: SettingsStoring = SecureStorage.shared
    private let dateFormatter = DateFormatter()
    
    var subscribers = [Weak<UserInfoStorageServiceSubscriber>]()
    
    var userInfo: UserInfo {
        get { getUserInfo() }
        set { saveUserInfo(newValue) }
    }
    
    var lastAdsWatchDate: Date? { getDate() }
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
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
    
    func saveDate(_ dateString: String) {
        let dateString = String(dateString.prefix(19))
        guard let _ = dateFormatter.date(from: dateString)
        else { return }
        
        try? secureStorrage.set(dateString, for: .lastAdsWatchDate)
    }
    
    // MARK: - Private methods
    
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
    
    private func getDate() -> Date? {
        guard let dateString = secureStorrage.getStringValue(for: .lastAdsWatchDate),
              let date = dateFormatter.date(from: dateString)
        else { return nil }

        return date
    }
}

extension Array where Element: Weak<UserInfoStorageServiceSubscriber> {
    
    mutating func reap() {
        self = self.filter { nil != $0.value }
    }
}
