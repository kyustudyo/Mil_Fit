//
//  MainCalorieViewController.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/11.
//

import Foundation
import UIKit

// 숫자 컴마

class MainCalorieViewController: UIViewController {
    
    var mealCalories:[CGFloat] = [2022, 2405, 2800, 3300, 2700, 2100, 2300]
    var workoutCalories:[CGFloat] = [0, 0, 0, 0, 0, 0, 0]
    let 요일들 = ["월", "화", "수", "목", "금", "토", "일"]
    
    override func viewDidLoad() {
        navigationItem.title = "칼로리"
        navigationController?.navigationBar.topItem?.backButtonTitle = "메인"
        
        let 오늘요일 = getDayOfWeek(date: Date().addingTimeInterval(60*60*9))
        print(오늘요일)
        let 몇번째요일 = Int(요일들.firstIndex(of: 오늘요일) ?? 0)
        let 뒤에몇요일이있나 = 6 - 몇번째요일
        print(오늘요일, 몇번째요일, 뒤에몇요일이있나)
        
        let 앞에날짜들개수 = 몇번째요일
        let 뒤에날짜들개수 = 뒤에몇요일이있나 // 1
        
        var 앞에날짜들모음: [Date] = []
        var 뒤에날짜들모음: [Date] = []
        var 전체날짜들모음: [Date] = []
        let 오늘날짜 = Date().addingTimeInterval(60*60*9) ?? Date()
        if 앞에날짜들개수 != 0 {
            for i in 1...앞에날짜들개수 {
                앞에날짜들모음.append(Calendar.current.date(byAdding: .day, value: -i, to: Date().addingTimeInterval(60*60*9)) ?? Date())
            }
        }
        
        if 뒤에날짜들개수 != 0 {
            for j in 1...뒤에날짜들개수 {
                뒤에날짜들모음.append(Calendar.current.date(byAdding: .day, value: j, to: Date().addingTimeInterval(60*60*9)) ?? Date())
            }
        }
        
//        print(앞에날짜들모음, "!!!",뒤에날짜들모음)
        전체날짜들모음 = [오늘날짜] + 앞에날짜들모음 + 뒤에날짜들모음
//        let a = 전체날짜들모음.map{ getDayOfWeek(date:$0)}
//        print(a)
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateformatter.locale = Locale(identifier: "ko_KR")
        
        for (i,date) in 전체날짜들모음.enumerated() {
            if let mealDate = RealmManager.searchMealDataByDate(date: dateformatter.string(from: date)) {
                if mealDate.count != 0 {
                    print(getDayOfWeek(date: date))
                    mealCalories[i] = CGFloat(mealDate[0].calories)
                }
            }
        }
        
        let dateFormatterForWorkout = DateFormatter()
        dateFormatterForWorkout.locale = Locale(identifier: "ko_KR")
        dateFormatterForWorkout.dateFormat = "yyyyMMdd"

        print("--")
        for (i,date) in 전체날짜들모음.enumerated() {
            if let workoutDate = RealmManager.searchWorkoutDataByDateK(date: dateFormatterForWorkout.string(from: date)) {
                if workoutDate.count != 0 {
//                    print(getDayOfWeek(date: date))
//                    print("운동칼로리", workoutDate[0].calories)
                    let workoutCal = Double(Array(workoutDate.map { $0.calories ?? 0}).reduce(0, +))
//                    print("총cal:", workoutCal)
                    workoutCalories[i] = workoutCal
                }
            }
        }
        
        
        
        view.backgroundColor = .systemGray6
        let mealContainerView = UIView()
        view.addSubview(mealContainerView)
        mealContainerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 16, paddingRight: 16, height: (view.frame.width - 32)/2 + 25 )
        decorateContainerView(view: mealContainerView, 종류: .섭취, 칼로리들: mealCalories)
        
        
        let workoutContainerView = UIView()
        view.addSubview(workoutContainerView)
        workoutContainerView.anchor(top: mealContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 18, paddingLeft: 16, paddingRight: 16, height: (view.frame.width - 32)/2 + 25 )
        decorateContainerView(view: workoutContainerView, 종류: .운동, 칼로리들: workoutCalories)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func decorateContainerView(view: UIView, 종류: 섭취운동사진, 칼로리들: [CGFloat]) {
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        let imageView = systemImageView(종류: 종류)
        let label = UILabel()
        label.text = 종류 == .섭취 ? "섭취" : "운동"
        label.font = .systemFont(ofSize: Constants.middleText, weight: .bold)
        let calorieView = getCalorieLabel(calorie: Int(칼로리들.reduce(0, +)) / 7)
        
        let hstackView = UIStackView(arrangedSubviews: [imageView, label, calorieView])
//        hstackView.distribution = .equalSpacing
        hstackView.spacing = 8
        calorieView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.addSubview(hstackView)
        hstackView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15)
        
        var barGraphs: [UIView] = []
        
        let maxCal = 칼로리들.max() ?? 0
        
        for i in 0..<7 {
            let graph = UIView()
            graph.setWidth(width: 16)
            
            
            graph.setHeight(height: 칼로리들[i] / maxCal * 100)
            graph.layer.cornerRadius = 4
            graph.backgroundColor = 종류 == .섭취 ? CustomColor.subtlePurple : CustomColor.red
            
            let label = UILabel()
            label.text = ["월", "화", "수", "목", "금", "토", "일"][i]
//            label.text = "\(칼로리들[i])"
            label.font = .systemFont(ofSize: Constants.smallText - 4, weight: .medium)
            
            let vstack = UIStackView(arrangedSubviews: [graph, label])
            vstack.axis = .vertical
            vstack.spacing = 8
            vstack.alignment = .center
            barGraphs.append(vstack)
        }
        
        let barGraphsHstack = UIStackView(arrangedSubviews: barGraphs)
        barGraphsHstack.spacing = 8
        barGraphsHstack.alignment = .bottom
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
    
    fileprivate func getCalorieLabel(calorie: Int) -> UIView {
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

    enum 섭취운동사진: String {
        case 섭취 = "fork.knife"
        case 운동 = "figure.walk"
    }
    
}
