//
//  Array+weakObjects.swift
//  ClubhouseAvatarMaker
//
//  Created by ‘Anton on 30.03.21.
//

import Foundation

class Weak<T: AnyObject> {
        
    weak var value: T?
    
    init (value: T) {
        self.value = value
    }
}

extension Array where Element: Weak<AnyObject> {
    
    mutating func reap() {
        self = self.filter { nil != $0.value }
    }
}
