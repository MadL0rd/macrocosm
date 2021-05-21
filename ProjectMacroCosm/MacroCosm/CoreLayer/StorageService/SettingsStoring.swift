//
//  SettingsStoring.swift
//  MacroCosm
//
//  Created by Антон Текутов on 01.04.2021.
//

import Foundation

protocol SettingsStoring {
    func set(_ itemValue: Bool, for itemKey: StorageItemKey) throws
    func set(_ itemValue: String, for itemKey: StorageItemKey) throws

    func getBoolValue(for itemKey: StorageItemKey) -> Bool?
    func getStringValue(for itemKey: StorageItemKey) -> String?

    func deleteValue(for itemKey: StorageItemKey) throws
}
