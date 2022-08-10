//
//  UIView.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/10.
//

import Foundation
import UIKit

extension UIView {
    func setGradient(color1: UIColor, color2: UIColor, cornerRadius: CGFloat) {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = bounds
        gradient.cornerRadius = cornerRadius
        layer.addSublayer(gradient)
    }
}
