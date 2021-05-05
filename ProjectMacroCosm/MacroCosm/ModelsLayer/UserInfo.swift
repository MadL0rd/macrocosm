//
//  UserInfo.swift
//  MacroCosm
//
//  Created by Антон Текутов on 31.03.2021.
//

import Foundation
import CoreLocation

struct UserInfo: Codable {
    
    var date: Date?
    var time: Date?
    var birthLocation: UserBirthLocation?
    
    var zodiacIndex: Int? {
        return date?.zodiac.rawValue
    }
    
    var isFilled: Bool {
        return date != nil && time != nil 
    }
}

struct UserBirthLocation: Codable {
    
    let title: String
    let latitude: Double
    let longitude: Double
}
