//
//  PredictModels.swift
//  MacroCosm
//
//  Created by Антон Текутов on 31.03.2021.
//

import Foundation

struct ZodiacPrediction: Codable {
    
    let zodiacName: String
    let zodiacImageUrlString: String
    let zodiacDescription: String
    let zodiacInfoText: String
    let prediction: PredictionDaily
    
    var zodiacImageUrl: URL? {
        return URL(string: zodiacImageUrlString)
    }
    
    enum CodingKeys: String, CodingKey {
        case prediction = "predict"
        case zodiacName = "name"
        case zodiacImageUrlString = "image"
        case zodiacDescription = "short_description"
        case zodiacInfoText = "description"
    }
}

struct PredictionDaily: Codable {
    
    let info: String?
    let dateString: String?
    let predictionBlocks: [PredictionBlock]
    
    enum CodingKeys: String, CodingKey {
        case dateString = "date"
        case info = "quote"
        case predictionBlocks = "blocks"
    }
}

struct PredictionBlock: Codable {
    
    let header: String?
    let text: String?
}
