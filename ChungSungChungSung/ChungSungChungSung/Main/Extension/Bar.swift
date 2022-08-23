//
//  Bar.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/07.
//

import Foundation
import UIKit

class Bar: UIView {
    
    var progressView = UIView()
    // @IBInspectable public var trackColor:UIColor = UIColor.gray
    @IBInspectable public var progressColor:UIColor = UIColor()
    @IBInspectable public var progressValue:Double = 0.0
    /// The color of the progress bar
    @IBInspectable public var barColor: UIColor = UIColor.green
    
    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2.0
//        setup()
        update()
    }

    @IBInspectable var trackColor: UIColor? {
        get {
            return UIColor()
        }
        set {
            self.backgroundColor = newValue
        }
    }
//    func setup(){
//        
//        self.clipsToBounds = true
//        self.layer.cornerRadius = self.frame.height / 2.0
//        
//        self.layer.borderColor = UIColor.clear.cgColor
//        self.layer.borderWidth = 1.0
//        
//        let total =  Double(self.frame.width)
//        let width =  ((total * progressValue) / 100.0).rounded()
//        let height = Double(self.frame.height)
//        progressView = UIView(frame: CGRect(x: 0, y: 0, width:  width, height: height))
//        self.addSubview(progressView)
//        progressView.backgroundColor = progressColor
//        self.progressView.clipsToBounds = true
//        self.progressView.layer.cornerRadius = self.frame.height / 2.0
//        
//    }
    func update() {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 1.0
        let total =  Double(self.frame.width)
//        print("eat",progressValue)
//        print("eat2,", total)
        let width =  ((total * progressValue) / 100.0).rounded()
        let height = Double(self.frame.height)
        progressView = UIView(frame: CGRect(x: 0, y: 0, width:  width, height: height))
//        print("count", self.subviews.count)
        self.subviews.forEach({ $0.removeFromSuperview()})
//        if self.subviews.count == 1 {
            self.addSubview(progressView)
//        }
//        else if self.subviews.count > 1 {
            
//            self.addSubview(progressView)
//        }
        progressView.backgroundColor = progressColor
        self.progressView.clipsToBounds = true
        self.progressView.layer.cornerRadius = self.frame.height / 2.0
    }
}
