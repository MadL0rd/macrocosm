//
//  UIView+RoundedCorners.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 30.03.21.
//

import UIKit

extension UIView {
    
    func roundCorners(corners: CACornerMask, radius: CGFloat = 8) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}
