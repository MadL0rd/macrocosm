//
//  LongPressDurationGestureRecognizer.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit.UIGestureRecognizerSubclass

class LongPressDurationGestureRecognizer: UIGestureRecognizer {
    
    private var startTime: Date?
    private(set) var duration = 0.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        startTime = Date()
        state = .began
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        duration = Date().timeIntervalSince(startTime!)
        state = .ended
    }
}
