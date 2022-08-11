//
//  MainMealTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/10.
//

import Foundation

import UIKit

class MainMealTableViewCell: UITableViewCell {
    
    let data: String = ""
    
    fileprivate var forkKnife: UIView = {
        let forkKnife = UIImage(systemName: "fork.knife")
        let imageView = UIImageView(image: forkKnife)
        imageView.anchor(width: 14, height: 15)
        
        imageView.tintColor = .진보라
        return imageView
    }()
    
    var whenMealLabel: UILabel = {
        let mealLabel = UILabel()
        mealLabel.textColor = .진보라
        mealLabel.font = UIFont.systemFont(ofSize: Constants.smallText, weight: .medium)
        return mealLabel
    }()
    
    var calorieLabel: UILabel = {
        let calorieLabel = UILabel()
        calorieLabel.font = UIFont.systemFont(ofSize: Constants.smallText - 6, weight: .light)
        calorieLabel.textColor = .gray
        return calorieLabel
    }()
    
    var mealStrings: [String] = [] {
        willSet {
            render(newValue)
        }
    }
    
//    var mealLabels: [UILabel] = {
//        let labels: [UILabel] = []
//        return labels
//    }()
//
//    func mealCommnentLabel(when: String) -> UIView {
//
//        let forkKnife = UIImage(systemName: "fork.knife")
//        forkKnife?.withTintColor(.red)
//        let imageView = UIImageView(image: forkKnife)
//        imageView.anchor(width: 14, height: 14)
//
//        let mealLabel = UILabel()
//        mealLabel.text = when
//        mealLabel.textColor = .진보라
//
//        let hStackView = UIStackView(arrangedSubviews: [imageView, mealLabel])
//
//        return hStackView
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render([])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(_ meals: [String]) {
        cardShadow()
        
        let forkAndWhenMeal = UIStackView(arrangedSubviews: [forkKnife, whenMealLabel])
        forkAndWhenMeal.spacing = 4
        contentView.addSubview(forkAndWhenMeal)
        forkAndWhenMeal.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 22, paddingLeft: 28)
        contentView.addSubview(calorieLabel)
        calorieLabel.anchor(top: forkAndWhenMeal.bottomAnchor, left: whenMealLabel.leftAnchor, paddingTop: 6, paddingLeft: 0)
        calorieLabel.text? += "kcal"
        let mealLabels: [UILabel] = meals.map {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: Constants.smallText - 3, weight: .light)
            label.text = $0
            return label
        }
        
        let mealVstack = UIStackView(arrangedSubviews: mealLabels)
        mealVstack.axis = .vertical
        contentView.addSubview(mealVstack)
        mealVstack.anchor(top: forkAndWhenMeal.topAnchor, left: forkAndWhenMeal.rightAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingRight: 61)
        
        self.backgroundColor = .white
    }
    
}


extension UIView {
    func cardShadow() {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = false
    }
}
