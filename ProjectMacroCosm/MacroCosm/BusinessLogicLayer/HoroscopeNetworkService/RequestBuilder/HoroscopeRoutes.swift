//  HoroscopeRoutes.swift
//  MacroCosm
//
//  Created by Антон Текутов on 31.03.2021.
//

import Alamofire

enum HoroscopeRoutes: String, URLConvertible {
    
    static let endpoint = "http://80.78.247.50:8008/"
    
    case daylyPrediction = "api/zodiak/"
    case date = "api/server_time/"

    func asURL() throws -> URL {
        guard let url = URL(string: HoroscopeRoutes.endpoint + self.rawValue)
        else { throw RequestBuildError.cannotCreateUrl }
        return url
    }
    
    static func makeAuthHeadersFromToken(token: String, contentType: ContentType? = nil) -> HTTPHeaders {
        if let contentType = contentType {
            return [
                "Authorization": "Token \(token)",
                "Content-Type": contentType.rawValue
            ]
        } else {
            return ["Authorization": "Token \(token)"]
        }
    }
}

enum ContentType: String {
    case json = "application/json"
    case formData = "multipart/form-data"
}
