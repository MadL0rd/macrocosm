//
//  KeychainStorageError.swift
//  MacroCosm
//
//  Created by Антон Текутов on 01.04.2021.
//

import Foundation

enum KeychainStorageError: Error {
    case itemNotFound
    case failedToSetValue
    case failedToUpdateValue
    case failedToDeleteValue
    case failedToConvertToData
}
