//
//  DronViewExtension.swift
//  Dron
//
//  Created by Alexander on 19.07.18.
//  Copyright © 2018 DMTech. All rights reserved.
//

import UIKit

extension UIView {
    func roundCornersWithBorder(_ corners:UIRectCorner,_ cormerMask:CACornerMask, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.borderWidth = 1
            self.clipsToBounds = false
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cormerMask
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
            self.layer.mask = rectShape
            let borderLayer = CAShapeLayer()
            borderLayer.path = rectShape.path
            borderLayer.lineWidth = 1.0
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = UIColor.black.cgColor
            borderLayer.frame = self.bounds
            self.layer.addSublayer(borderLayer)
        }
    }
}
