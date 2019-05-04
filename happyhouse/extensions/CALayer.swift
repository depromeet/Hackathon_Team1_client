//
//  CALayer.swift
//  happyhouse
//
//  Copyright © 2019 Depromeet. All rights reserved.
//

import UIKit

extension CALayer {
    
    func addShadow(radius: CGFloat, opacity: CGFloat, offsetX: CGFloat = 0, offsetY: CGFloat = 2) {
        self.shadowRadius = radius
        self.shadowOffset = CGSize(width: offsetX, height: offsetY)
        self.shadowOpacity = Float(opacity)
        self.shadowColor = UIColor.black.cgColor
        
    }
    
    func addBorder(width: CGFloat, color: CGColor) {
        self.borderColor = color
        self.borderWidth = width
    }
    
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        self.masksToBounds = true
    }
    
}

