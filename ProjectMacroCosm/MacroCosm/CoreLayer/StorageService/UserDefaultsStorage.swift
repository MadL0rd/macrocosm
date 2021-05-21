//
//  UserDefaultsStorage.swift
//  MacroCosm
//
//  Created by Антон Текутов on 01.04.2021.
//

import Foundation

final class UserDefaultsStorage: SettingsStoring {
    static let shared = UserDefaultsStorage()
    
    let userDefaults = UserDefaults.standard
    
    func set<Value>(_ value: Value, for key: StorageItemKey) throws {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func deleteValue(for key: StorageItemKey) throws {
        userDefaults.removeObject(forKey: key.rawValue)
    }
    
    func get<T>(forKey key: StorageItemKey) -> T? {
        userDefaults.value(forKey: key.rawValue) as? T
    }
    
    func getBoolValue(for itemKey: StorageItemKey) -> Bool? {
        return get(forKey: itemKey)
    }
    
    func getStringValue(for itemKey: StorageItemKey) -> String? {
        return get(forKey: itemKey)
    }
}
