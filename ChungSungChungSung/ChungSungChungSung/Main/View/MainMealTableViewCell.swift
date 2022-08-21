//
//  MainMealTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/10.
//

import Foundation

import UIKit
//calander 통합, dateformatterㅇ
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
    
    var label1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.smallText - 3, weight: .light)
        return label
    }()
    var label2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.smallText - 3, weight: .light)
        return label
    }()
    var label3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.smallText - 3, weight: .light)
        return label
    }()
    var label4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.smallText - 3, weight: .light)
        return label
    }()
    var label5: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.smallText - 3, weight: .light)
        return label
    }()
    var label6: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.smallText - 3, weight: .light)
        return label
    }()
    var label7: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.smallText - 3, weight: .light)
        return label
    }()
//    var mealStrings: [String] = []
//    {
//        willSet {
//            render(newValue)
//        }
//    }
    
//    var mealLabels: [UILabel] = {
//        let labels: [UILabel] = []
//        return labels
//    }()

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
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    var mealLabels: [UILabel] = []
    func render() {
        cardShadow()
        self.backgroundColor = .white
        let forkAndWhenMeal = UIStackView(arrangedSubviews: [forkKnife, whenMealLabel])
        forkAndWhenMeal.spacing = 4
        contentView.addSubview(forkAndWhenMeal)
        forkAndWhenMeal.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 18, paddingLeft: 20)
        contentView.addSubview(calorieLabel)
        calorieLabel.anchor(top: forkAndWhenMeal.bottomAnchor, left: whenMealLabel.leftAnchor, paddingTop: 6, paddingLeft: 0)
        calorieLabel.text? += "kcal"
        
//        mealLabels = meals.map {
//            let label = UILabel()
//            label.font = UIFont.systemFont(ofSize: Constants.smallText - 3, weight: .light)
//            label.text = $0
//            return label
//        }
        let mealVstack = UIStackView(arrangedSubviews: [label1, label2, label3,label4,label5, label6,label7])
        mealVstack.axis = .vertical
        contentView.addSubview(mealVstack)
        mealVstack.anchor(top: forkAndWhenMeal.topAnchor, paddingTop: 0)
        mealVstack.leftAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
//        if meals.isEmpty { return }
        
        
//        contentView.addSubview(label1)
//        label1.anchor(top: forkAndWhenMeal.topAnchor, paddingTop: 0)
//        label1.leftAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
//        let label0 = UILabel()
//        label0.text = meals[0]
//        contentView.addSubview(label0)
//        label0.centerY(inView: self)
//        label0.centerX(inView: self)
        
//        if meals.count > 0 {
//            let label0 = UILabel()
//            label0.text = meals[0]
//            contentView.addSubview(label0)
//            label0.centerY(inView: self)
//            label0.centerX(inView: self)
////            label0.anchor(top: forkAndWhenMeal.topAnchor, paddingTop: 0)
////            label0.leftAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        }
//        for str in meals {
//            let label0 = UILabel()
//            label0.text = str
//            mealVstack.addArrangedSubview(label0)
//        }
        
//        let views: [UIView] = mealLabels.map { v in
//            let uiview = UIView()
//            uiview.addSubview(v)
//            return uiview
//        }
//        let k = views.count
//        for i in 0..<k {
//            mealVstack.addArrangedSubview(views[i])
//        }
        
        
//        let label0 = UILabel()
//        label0.text = mealLabels[0].text
//        mealVstack.addArrangedSubview(label0)
//
//        let label1 = UILabel()
//        label1.text = mealLabels[1].text
//        mealVstack.addArrangedSubview(label1)
//        contentView.addSubview(label1)
        
        
        
    }

}


extension UIView {
    func cardShadow() {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = false
    }
}
