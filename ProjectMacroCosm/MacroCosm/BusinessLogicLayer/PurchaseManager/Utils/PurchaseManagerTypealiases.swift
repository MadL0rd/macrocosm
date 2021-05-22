//
//  PurchaseManagerTypealiases.swift
//  MacroCosm
//
//  Created by Антон Текутов on 22.05.2021.
//

import StoreKit

enum PurchaseVerification {
    case active
    case notPurchased
}

enum ResoreResult {
    case failed
    case success
    case nothingToRestore
    
    var localized: String {
        switch self {
        case .failed:
            return NSLocalizedString("Failed", comment: "")
        case .success:
            return NSLocalizedString("Success", comment: "")
        case .nothingToRestore:
            return NSLocalizedString("Nothing to restore", comment: "")
        }
    }
}

typealias CheckActivePurchasesCompletion = (Result<PurchaseVerification, Error>) -> Void
typealias GetPurchaseInfoCompletion = (SKProduct) -> Void
typealias RestorePurchasesCompletion = (ResoreResult) -> Void

