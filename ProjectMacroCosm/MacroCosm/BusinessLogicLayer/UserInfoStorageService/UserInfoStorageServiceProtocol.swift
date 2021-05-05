//
//  UserInfoStorageServiceProtocol.swift
//  MacroCosm
//
//  Created by Антон Текутов on 01.04.2021.
//

import Foundation

protocol UserInfoStorageServiceProtocol: class {
    
    var userInfo: UserInfo { get set }
    
    func subscribe(_ subscriber: UserInfoStorageServiceSubscriber)
    func needToReloadData()
}
