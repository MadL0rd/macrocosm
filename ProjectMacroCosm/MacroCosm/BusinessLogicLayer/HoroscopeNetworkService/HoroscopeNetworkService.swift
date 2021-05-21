//  HoroscopeNetworkService.swift
//  MacroCosm
//
//  Created by Антон Текутов on 31.03.2021.
//

import Alamofire

class HoroscopeNetworkService: NetworkService {
    
    static let shared: HoroscopeNetworkServiceProtocol = HoroscopeNetworkService()
    
    private let requestBuilder = HoroscopeRequestBuilder.self
}

extension HoroscopeNetworkService: HoroscopeNetworkServiceProtocol {
    
    func getDaylyPrediction(zodiacId: Int, completion: @escaping GetPredictionCompletion) {
        makeDefaultRequest(dataRequest: requestBuilder.daylyPrediction(zodiacId: zodiacId),
                           completion: completion)
    }
    
    func getDate(completion: @escaping GetDateCompletion) {
        makeDefaultRequest(dataRequest: requestBuilder.date,
                           completion: completion)
    }

}
