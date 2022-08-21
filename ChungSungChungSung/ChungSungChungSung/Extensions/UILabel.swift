//
//  UILabel.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/19.
//

import UIKit

extension UILabel {
    func setTargetStringColor(targetString: String, color: UIColor) {
        guard let fullText = text else { return }
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}
