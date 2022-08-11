//
//  MainCalorieViewController.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/11.
//

import Foundation
import UIKit

class MainCalorieViewController: UIViewController {
    
    override func viewDidLoad() {
        
        let mealContainerView = UIView()
        view.addSubview(mealContainerView)
        mealContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 16, paddingRight: 16, height: (view.frame.width - 32)/2 )
        decorateContainerView(view: mealContainerView, 종류: .운동, 평균칼로리: 1400.0, 칼로리들: [10.0, 12.0, 14.0, 13.0, 8.0, 5.0, 9.0])
        
        
        let workoutContainerView = UIView()
        view.addSubview(workoutContainerView)
        workoutContainerView.anchor(top: mealContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingRight: 16, height: (view.frame.width - 32)/2 )
        decorateContainerView(view: workoutContainerView, 종류: .섭취, 평균칼로리: 120.0, 칼로리들: [10.0, 12.0, 14.0, 13.0, 8.0, 5.0, 9.0])
        
    }
    
    func decorateContainerView(view: UIView, 종류: 섭취운동사진, 평균칼로리: CGFloat, 칼로리들: [CGFloat]) {
        view.backgroundColor = .red
        view.layer.cornerRadius = 12
        let imageView = systemImageView(name: 종류.rawValue)
        let calorieView = getCalorieLabel(calorie: 평균칼로리)
        
        let hstackView = UIStackView(arrangedSubviews: [imageView, calorieView])
//        hstackView.distribution = .fill
        calorieView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.addSubview(hstackView)
        hstackView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15)
        hstackView.backgroundColor = .systemGray6
        
        
    }
    
    fileprivate func systemImageView(name: String) -> UIImageView {
        let image = UIImage(systemName: name)
        let imageView = UIImageView(image: image)
        imageView.anchor(width: 14, height: 15)
        imageView.tintColor = .진보라
        return imageView
    }
    
    fileprivate func getCalorieLabel(calorie: CGFloat) -> UIView {
        let averageLabel = UILabel()
        averageLabel.text = "이번 주 평균"
        let calorieLabel = UILabel()
        calorieLabel.text = "\(calorie)"
        let stackView = UIStackView(arrangedSubviews: [averageLabel])
        return stackView
    }
    
//    fileprivate var forkKnife: UIView = {
//        let forkKnife = UIImage(systemName: "fork.knife")
//        let imageView = UIImageView(image: forkKnife)
//        imageView.anchor(width: 14, height: 15)
//
//        imageView.tintColor = .진보라
//        return imageView
//    }()
    
    enum 섭취운동사진: String {
        case 섭취 = "fork.knife"
        case 운동 = "figure.walk"
    }
    
}
