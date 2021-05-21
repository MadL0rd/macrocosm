//  HoroscopeNetworkServiceProtocol.swift
//  MacroCosm
//
//  Created by Антон Текутов on 31.03.2021.
//

import Foundation

protocol HoroscopeNetworkServiceProtocol: AnyObject {
    
    func getDaylyPrediction(zodiacId: Int, completion: @escaping GetPredictionCompletion)
    func getDate(completion: @escaping GetDateCompletion)
}

