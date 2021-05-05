//
//  Date+zodiac.swift
//  MacroCosm
//
//  Created by Антон Текутов on 01.04.2021.
//

import Foundation

public enum Zodiac: Int {
    case undefined
    case aries
    case taurus
    case gemini
    case cancer
    case lion
    case virgo
    case libra
    case scorpio
    case sagittarius
    case capicorn
    case aquarius
    case pisces
}

extension Date {
    
    public var zodiac: Zodiac {
        guard let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
            else { return .undefined }
        
        let dateComponents = gregorianCalendar.components([.month, .day], from: self)
        
        let month = dateComponents.month
        let day = dateComponents.day
        
        switch (month!, day!) {
        case (3, 21...31), (4, 1...19):
            return .aries
        case (4, 20...30), (5, 1...20):
            return .taurus
        case (5, 21...31), (6, 1...20):
            return .gemini
        case (6, 21...30), (7, 1...22):
            return .cancer
        case (7, 23...31), (8, 1...22):
            return .lion
        case (8, 23...31), (9, 1...22):
            return .virgo
        case (9, 23...30), (10, 1...22):
            return .libra
        case (10, 23...31), (11, 1...21):
            return .scorpio
        case (11, 22...30), (12, 1...21):
            return .sagittarius
        case (12, 22...31), (1, 1...19):
            return .capicorn
        case (1, 20...31), (2, 1...18):
            return .aquarius
        case (2, 19...29), (3, 1...20):
            return .pisces
        default:
            return .undefined
        }
    }
}
