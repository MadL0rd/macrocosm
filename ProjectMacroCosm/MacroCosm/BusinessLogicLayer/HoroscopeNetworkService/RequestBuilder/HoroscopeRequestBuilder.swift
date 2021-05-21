//  HoroscopeRequestBuilder.swift
//  MacroCosm
//
//  Created by Антон Текутов on 31.03.2021.
//

import Alamofire

enum HoroscopeRequestBuilder {
    
    case daylyPrediction(zodiacId: Int)
    case date
}

extension HoroscopeRequestBuilder: DataRequestExecutable {
    
    var execute: DataRequest {
        switch self {
        case .daylyPrediction(zodiacId: let zodiacId):
            let url = URL(string: "\(HoroscopeRoutes.endpoint)\(HoroscopeRoutes.daylyPrediction.rawValue)\(zodiacId)/")!
            
            return AF.request(url, method: .get)
            
        case .date:
            return AF.request(HoroscopeRoutes.date)
        }
    }
}
