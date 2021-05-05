//
//  String+capitalizingFirstLetter.swift
//  ClubhouseAvatarMaker
//
//  Created by ‘Anton on 30.03.21.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
