//
//  DisableAdsPurchaseViewModelProtocol.swift
//  MacroCosm
//
//  Created by Антон Текутов on 21.05.2021.
//

protocol DisableAdsPurchaseViewModelProtocol: AnyObject {
    
    func loadPurchasePrice(_ completion: @escaping(String) -> Void)
    func buyDisableAdsPurchase(callback: @escaping(Bool) -> Void)
}
