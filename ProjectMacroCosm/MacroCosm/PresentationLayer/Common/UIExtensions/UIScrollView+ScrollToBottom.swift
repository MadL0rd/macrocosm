//
//  UIScrollView+ScrollToBottom.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 30.03.21.
//

import UIKit

extension UIScrollView {
    
    func scrollsToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
}
