//
//  UIColor.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/07.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var opacity: CGFloat = 1.0
        let length = hexSanitized.count
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        if length == 6 {
            red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            opacity = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        self.init(red: red, green: green, blue: blue, alpha: opacity)
    }
}

class CustomColor {
    static let mainPurple = UIColor(hex: "7157DB")
    static let gradientPurple = UIColor(hex: "AA90EF")
    static let bgGray = UIColor(hex: "F9FAFA")
    static let dateGreen = UIColor(hex: "50E6A8")
    static let editGray = UIColor(hex: "828282")
    static let red = UIColor(hex: "F0827D")
    static let subtlePurple = UIColor(hex: "7D93F8")
    static let strongPurple = UIColor(hex: "8E79E1")
    static let verySubtlePurple = UIColor(hex: "6452B0")?.withAlphaComponent(0.1)
    static let calendarRedColor = UIColor(hex: "FEB4B4")
    static let blue = UIColor(hex: "7D93F8")
}
