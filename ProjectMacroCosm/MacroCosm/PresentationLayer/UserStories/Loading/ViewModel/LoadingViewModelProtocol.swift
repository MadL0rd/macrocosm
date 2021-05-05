//
//  LoadingViewModelProtocol.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.21.
//

protocol LoadingViewModelProtocol: class {
    
    var userInfo: UserInfo { get }
    
    func startConfiguration()
}
