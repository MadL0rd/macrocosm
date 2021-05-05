//  HoroscopeNetworkServiceProtocol.swift
//  MacroCosm
//
//  Created by Антон Текутов on 31.03.2021.
//

import Foundation

protocol HoroscopeNetworkServiceProtocol: class {
    
    func getDaylyPrediction(zodiacId: Int, completion: @escaping GetSettingsCompletion)
}

