//
//  SettingsViewModelProtocol.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import Foundation

protocol SettingsViewModelProtocol: AnyObject {
    
    var termsOfUsageUrl: URL? { get }
    var privacyPolicyUrl: URL? { get }
    var supportUrl: URL? { get }
    
    func rateApp()
    func checkPurchaseStatus(_ completionHandler: @escaping(PurchaseVerification) -> Void)
    func restorePurchases(_ callback: @escaping RestorePurchasesCompletion)
}
