//
//  ImageViewExtension.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/09.
//

import UIKit

extension UIImage {

    public enum GradientOrientation {
        case vertical
        case horizontal
    }
    
    public convenience init?(bounds: CGRect, colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map({ $0.cgColor })
        
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
