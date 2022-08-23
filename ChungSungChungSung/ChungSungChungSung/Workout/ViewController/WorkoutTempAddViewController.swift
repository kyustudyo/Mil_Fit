//
//  WorkoutTempAddViewController.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/21.
//

import UIKit
import RealmSwift
import Toast_Swift
import SwiftUI

class WorkoutTempAddViewController: UIViewController {

    @IBOutlet weak var rectangleView: UIView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    var workoutAddTitleText = ""
    var selectedDate = Date()
    var workoutInfo: (WorkOutType, Double)!
    var localRealm: Realm!
    var workoutRealm: WorkoutRealm!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = CustomColor.bgGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = CustomColor.mainPurple
        navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        navigationItem.title = workoutAddTitleText
        navigationItem.largeTitleDisplayMode = .never
        workoutInfo = basicWorkoutData[workoutAddTitleText]!
        localRealm = try! Realm()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        workoutRealm = localRealm.objects(WorkoutRealm.self).filter("dateSearching == '\(dateFormatter.string(from: selectedDate))'").filter("name == '\(workoutAddTitleText)'").first!
        caloriesLabel.text = "추정 칼로리:"
        setUI()
    }
    @objc func saveButtonClicked() {
        let validNumber = isValid()
        switch validNumber {
        case 0 :
            try! localRealm.write({
                if workoutInfo.0 == .무게운동 {
                    workoutRealm.weight = Int(firstTextField.text ?? "0")
                    workoutRealm.count = Int(secondTextField.text ?? "0")
                }else if workoutInfo.0 == .시간운동 {
                    workoutRealm.minutes = Int(firstTextField.text ?? "0")
                    workoutRealm.seconds = Int(secondTextField.text ?? "0")
                }else {
                    workoutRealm.count = Int(secondTextField.text ?? "0")
                }
                workoutRealm.calories = caloriesCalculator()
            })
            view.makeToast("저장되었습니다.", duration: 3.0, position: .top)
            setUI()
        case 1 : view.makeToast("빈칸없이 입력해주세요", duration: 3.0, position: .top)
        case 2: view.makeToast("숫자만 입력해주세요", duration: 3.0, position: .top)
        default: break
        }
    }
    
    func isValid() -> Int {
        if workoutInfo.0 == .무게운동 {
            if firstTextField.text == "" || secondTextField.text == "" {
                return 1
            }
        } else if workoutInfo.0 == .시간운동{
            if firstTextField.text == "" && secondTextField.text == "" {
                return 1
            }
        } else {
            if secondTextField.text == "" {
                return 1
            }
        }
        if workoutInfo.0 == .무게운동 {
            if Int(firstTextField.text ?? "") == nil ||
              Int(secondTextField.text ?? "") == nil {
            return 2
            }
        }else if workoutInfo.0 == .시간운동 {
            if firstTextField.text == nil {
                if Int(secondTextField.text!) == nil {
                    print("여기")
                    return 2
                }
            }else if secondTextField.text == nil {
                if Int(firstTextField.text!) == nil {
                    print("저기")
                    return 2
                }
            }else {
                if Int(firstTextField.text!) == nil &&
                    Int(secondTextField.text!) == nil {
                print("거기")
                  return 2
                }
            }
        }else {
            if Int(secondTextField.text!) == nil {
                return 2
            }
        }
           
        return 0
    }
    
    func setUI() {
        rectangleView.backgroundColor = .systemGray6
        rectangleView.layer.cornerRadius = 20
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateLabel.text = "\(dateFormatter.string(from: selectedDate))"
        dateLabel.textColor = .systemGray2
        if workoutInfo.0 == .무게운동 {
            firstLabel.text = "kg"
            secondLabel.text = "회"
            if workoutRealm.weight != nil {
                firstTextField.text = "\(workoutRealm.weight!)"
                
            }
            if workoutRealm.count != nil {
                secondTextField.text = "\(workoutRealm.count!)"
                caloriesLabel.text = "추정 칼로리 : \(caloriesCalculator())Kcal"
            }
        }else if workoutInfo.0 == .횟수운동 {
            firstLabel.isHidden = true
            firstTextField.isHidden = true
            secondLabel.text = "회"
            if workoutRealm.count != nil {
                secondTextField.text = "\(workoutRealm.count!)"
                caloriesLabel.text = "추정 칼로리 : \(caloriesCalculator())Kcal"
            }
        }else {
            firstLabel.text = "시간"
            secondLabel.text = "분"
            if workoutRealm.minutes != nil {
                firstTextField.text = "\(workoutRealm.minutes!)"
            }
            if workoutRealm.seconds != nil {
                secondTextField.text = "\(workoutRealm.seconds!)"
            }
            if workoutRealm.minutes != nil || workoutRealm.seconds != nil {
                caloriesLabel.text = "추정 칼로리 : \(caloriesCalculator())Kcal"
            }
        }
    }
    func caloriesCalculator() -> Int {
        var time:Double = 0
        var calories = 0
        let weight = localRealm.objects(WeightRealm.self).sorted(byKeyPath: "dateSorting", ascending: false).first?.weight
        if workoutInfo.0 == .시간운동 {
            time = Double((workoutRealm.minutes ?? 0) * 60) + (Double(workoutRealm.seconds ?? 0))
        }else {
            time = Double(workoutRealm.count ?? 0) * 0.8
        }
        let met: Double = workoutInfo.1
        let weightDouble: Double = Double(weight ?? 0)
        calories = Int(((met * (3.5 * weightDouble * time)) / 1000) * 5)
        return calories
    }
}
