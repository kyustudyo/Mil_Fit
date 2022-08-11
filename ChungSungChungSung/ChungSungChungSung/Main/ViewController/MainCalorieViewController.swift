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
        navigationItem.title = "칼로리"
        navigationController?.navigationBar.topItem?.backButtonTitle = "메인"
        
        view.backgroundColor = .systemGray6
        let mealContainerView = UIView()
        view.addSubview(mealContainerView)
        mealContainerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 16, paddingRight: 16, height: (view.frame.width - 32)/2 + 25 )
        decorateContainerView(view: mealContainerView, 종류: .섭취, 평균칼로리: 1400.0, 칼로리들: [10.0, 12.0, 14.0, 13.0, 8.0, 5.0, 9.0])
        
        
        let workoutContainerView = UIView()
        view.addSubview(workoutContainerView)
        workoutContainerView.anchor(top: mealContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 18, paddingLeft: 16, paddingRight: 16, height: (view.frame.width - 32)/2 + 25 )
        decorateContainerView(view: workoutContainerView, 종류: .운동, 평균칼로리: 120.0, 칼로리들: [10.0, 12.0, 14.0, 13.0, 8.0, 5.0, 9.0])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func decorateContainerView(view: UIView, 종류: 섭취운동사진, 평균칼로리: CGFloat, 칼로리들: [CGFloat]) {
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        let imageView = systemImageView(종류: 종류)
        let label = UILabel()
        label.text = 종류 == .섭취 ? "섭취" : "운동"
        label.font = .systemFont(ofSize: Constants.middleText, weight: .bold)
        let calorieView = getCalorieLabel(calorie: 평균칼로리)
        
        let hstackView = UIStackView(arrangedSubviews: [imageView, label, calorieView])
//        hstackView.distribution = .equalSpacing
        hstackView.spacing = 8
        calorieView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.addSubview(hstackView)
        hstackView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15)
        
        var barGraphs: [UIView] = []
        
        for i in 0..<7 {
            let graph = UIView()
            graph.setWidth(width: 16)
            graph.setHeight(height: 100)
            graph.layer.cornerRadius = 4
            graph.backgroundColor = 종류 == .섭취 ? CustomColor.subtlePurple : CustomColor.red
            
            let label = UILabel()
            label.text = ["월", "화", "수", "목", "금", "토", "일"][i]
            label.font = .systemFont(ofSize: Constants.smallText - 4, weight: .medium)
            
            let vstack = UIStackView(arrangedSubviews: [graph, label])
            vstack.axis = .vertical
            vstack.spacing = 8
            vstack.alignment = .center
            
            barGraphs.append(vstack)
        }
        
        let barGraphsHstack = UIStackView(arrangedSubviews: barGraphs)
        barGraphsHstack.spacing = 8
        view.addSubview(barGraphsHstack)
        barGraphsHstack.distribution = .equalSpacing
        barGraphsHstack.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 27, paddingBottom: 17, paddingRight: 27)
        
    }
    
    fileprivate func systemImageView(종류: 섭취운동사진) -> UIView {
        let containerView = UIView()
        containerView.anchor(width: 30, height: 30)
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = 종류 == .섭취 ? CustomColor.subtlePurple : CustomColor.red
        let image = UIImage(systemName: 종류.rawValue)
        let imageView = UIImageView(image: image)
        imageView.anchor(width: 18)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        containerView.addSubview(imageView)
        imageView.centerX(inView: containerView)
        imageView.centerY(inView: containerView)
        
        return containerView
    }
    
    fileprivate func getCalorieLabel(calorie: CGFloat) -> UIView {
        let averageLabel = UILabel()
        averageLabel.text = "이번 주 평균"
        averageLabel.font = UIFont.systemFont(ofSize: Constants.smallText - 2, weight: .medium)
        let calorieLabel = UILabel()
        calorieLabel.text = "\(calorie)kcal"
        calorieLabel.font = UIFont.systemFont(ofSize: Constants.bigText, weight: .light)
        let stackView = UIStackView(arrangedSubviews: [averageLabel, calorieLabel])
        stackView.spacing = 8
        stackView.alignment = .firstBaseline
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
