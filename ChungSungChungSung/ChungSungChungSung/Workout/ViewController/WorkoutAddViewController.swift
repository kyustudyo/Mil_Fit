//
//  WorkoutAddViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/06.
//

import UIKit
import RealmSwift

class WorkoutAddViewController: UIViewController {
    private var numberOfSets: Int = 1
    private var estimatedCalorie: Double = 0
    
    var localRealm: Realm!
    var workoutRealm: Results<WorkoutRealm>!
    var workoutTemp: [WorkoutRealm] = []
//    var workoutTempModel = WorkoutTemp(set: 1)
    var firstInput = [String](repeating: "0", count: 50)
    var secondInput = [String](repeating: "0", count: 50)
    var workoutInfo: (WorkOutType, Double)!
    var minutes: [Int] = []
    var times: [Int] = []
    var weight: [Int] = []
    
    var workoutAddTitleText: String = "text"
//    var workout: WorkoutModel?
    var selectedDate = Date()
    
    var editDoneButtonText: String = "편집"
    
    @IBOutlet weak var workoutAddTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        navigationItem.title = workoutAddTitleText
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.topItem?.backButtonTitle = "운동"

        editDoneButtonConfig()
        
        let workoutAddTwoTableViewCellNib = UINib(nibName: "WorkoutAddTwoTableViewCell", bundle: nil)
        let workoutAddOneTableViewCellNib = UINib(nibName: "WorkoutAddOneTableViewCell", bundle: nil)
        let workoutAddPlusTableViewCellNib = UINib(nibName: "WorkoutAddPlusTableViewCell", bundle: nil)
        let workoutAddCalorieTableViewCellNib = UINib(nibName: "WorkoutAddCalorieTableViewCell", bundle: nil)
        
        workoutAddTable.register(workoutAddTwoTableViewCellNib, forCellReuseIdentifier: "workoutAddTwoTableViewCell")
        workoutAddTable.register(workoutAddOneTableViewCellNib, forCellReuseIdentifier: "workoutAddOneTableViewCell")
        workoutAddTable.register(workoutAddPlusTableViewCellNib, forCellReuseIdentifier: "workoutAddPlusTableViewCell")
        workoutAddTable.register(workoutAddCalorieTableViewCellNib, forCellReuseIdentifier: "workoutAddCalorieTableViewCell")
        
        workoutAddTable.backgroundColor = CustomColor.bgGray
        workoutAddTable.contentInset.top = 24
        
        localRealm = try! Realm()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        workoutRealm = localRealm.objects(WorkoutRealm.self).filter("dateSearching == '\(dateFormatter.string(from: selectedDate))'").filter("name == '\(workoutAddTitleText)'").sorted(byKeyPath: "dateSorting", ascending: true)
        
        workoutInfo = basicWorkoutData[workoutAddTitleText]!
//        workoutTemp.append(workoutTempModel)
    }
    
    private func editDoneButtonConfig() {
//        editDoneButton.setTitle("편집", for: .normal)
//        editDoneButton.tintColor = CustomColor.mainPurple
//        editDoneButton.addTarget(self, action: #selector(editDoneAction), for: .touchUpInside)
//        let editDoneBarButton = UIBarButtonItem(customView: editDoneButton)
//        editDoneBarButton.tintColor = CustomColor.mainPurple
        let editDoneBarButton = UIBarButtonItem(title: editDoneButtonText, style: .plain, target: self, action: #selector(editDoneAction))
        
//        let saveButton = UIButton()
//        saveButton.setTitle("저장", for: .normal)
//        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
//        let saveBarButton = UIBarButtonItem(customView: saveButton)
        let saveBarButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonAction))
        
        self.navigationItem.rightBarButtonItems = [saveBarButton, editDoneBarButton]
    }
    
    @objc func editDoneAction() {
        if self.workoutAddTable.isEditing {
            editDoneButtonText = "편집"
            self.workoutAddTable.setEditing(false, animated: true)
            
            // TODO: RealmManager.saveWorkoutData
            
        } else {
            editDoneButtonText = "완료"
            self.workoutAddTable.setEditing(true, animated: true)
        }
    }
    
    @objc func saveButtonAction() {
        if self.workoutAddTable.isEditing {
            
            self.workoutAddTable.setEditing(false, animated: true)
            
//            print(workoutTemp.count)
            
            for index in workoutTemp {
                RealmManager.saveWorkoutData(date: selectedDate, name: workoutAddTitleText, set: index.set, count: index.count, minutes: index.minutes, seconds: index.seconds, weight: index.weight, calories: index.calories)
            }
        } else {
//            print(workoutTemp.count)
            
            for i in 0...workoutTemp.count {
                if basicWorkoutData[workoutAddTitleText]?.0 == .시간운동 {
                    workoutTemp[i].minutes = Int(secondInput[i])
                } else if basicWorkoutData[workoutAddTitleText]?.0 == .무게운동 {
                    workoutTemp[i].weight = Int(firstInput[i])
                    workoutTemp[i].count = Int(secondInput[i])
                } else {
                    workoutTemp[i].count = Int(secondInput[i])
                }
            }
            
            for index in workoutTemp {
                RealmManager.saveWorkoutData(date: selectedDate, name: workoutAddTitleText, set: index.set, count: index.count, minutes: index.minutes, seconds: index.seconds, weight: index.weight, calories: index.calories)
            }
        }
    }
    
    public func endTextEdit(_ firstText: String, _ secondText: String, _ tag: Int) {
        if firstText != "" {
            firstInput[tag] = firstText
        }
        if secondText != "" {
            secondInput[tag] = secondText
//            print("text 가져옴")
        }
    }
}

extension WorkoutAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutRealm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == numberOfSets + 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddCalorieTableViewCell", for: indexPath) as? WorkoutAddCalorieTableViewCell else {
                return UITableViewCell()
            }
            
            // TODO: 칼로리 계산
            
            cell.backgroundColor = CustomColor.bgGray
            cell.estimatedCalorieView.text = "추정 칼로리: \(estimatedCalorie) kcal"

            return cell
        } else if (indexPath.row == numberOfSets) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddPlusTableViewCell", for: indexPath) as? WorkoutAddPlusTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = CustomColor.bgGray
            
            return cell
        } else {
            let setNumber = indexPath.row + 1
            if workoutInfo.0 == .횟수운동 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddOneTableViewCell", for: indexPath) as? WorkoutAddOneTableViewCell else {
                    return UITableViewCell()
                }
                cell.inputType.text = "회"
                cell.setNumberView.text = "\(setNumber)세트"
                cell.backgroundColor = CustomColor.bgGray
                return cell
            }else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddTwoTableViewCell", for: indexPath) as? WorkoutAddTwoTableViewCell else {
                    return UITableViewCell()
                }
                cell.setNumberView.text = "\(setNumber)세트"
                cell.backgroundColor = CustomColor.bgGray
                if workoutInfo.0 == .무게운동 {
                    cell.firstInputType.text = "분"
                    cell.secondInputType.text = "초"
                }else {
                    cell.firstInputType.text = "kg"
                    cell.secondInputType.text = "회"
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row < numberOfSets {
            return .delete
        } else if indexPath.row >= numberOfSets {
            return .none
        }
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == numberOfSets {
//            workoutTemp.append(workoutTempModel)
            
            workoutTemp[numberOfSets].set = numberOfSets + 1
            numberOfSets = numberOfSets + 1
            
//            print(indexPath.row)
//            print(numberOfSets)
            workoutAddTable.reloadData()
        }
    }
}
