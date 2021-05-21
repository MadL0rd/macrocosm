//  RequestResults.swift
//  MacroCosm
//
//  Created by Антон Текутов on 31.03.2021.
//

import Foundation

typealias GetDaylyPredictionRequestResult = ZodiacPrediction
typealias GetDateRequestResult = DateRequestResult

struct DateRequestResult: Codable {
    
    let serverTime: String
    
    enum CodingKeys: String, CodingKey {
        case serverTime = "server_time"
    }
}
