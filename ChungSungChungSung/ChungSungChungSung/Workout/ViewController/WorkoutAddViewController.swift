//
//  WorkoutAddViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/06.
//

import UIKit

class WorkoutAddViewController: UIViewController {
    private var numberOfSets: Int = 1
    private var estimatedCalorie: Double = 0
    
    var workoutAddTitleText: String = "text"
    var workout: WorkoutModel?
    
    @IBOutlet weak var workoutAddTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        navigationItem.title = workoutAddTitleText
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.topItem?.backButtonTitle = "운동"
        
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
    }
}

extension WorkoutAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfSets + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.row == numberOfSets + 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddCalorieTableViewCell", for: indexPath) as? WorkoutAddCalorieTableViewCell else {
                return UITableViewCell()
            }
            
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddTwoTableViewCell", for: indexPath) as? WorkoutAddTwoTableViewCell else {
                return UITableViewCell()
            }
            let setNumber = indexPath.row + 1
            cell.setNumberView.text = "\(setNumber)세트"
            
            if basicWorkoutData[workoutAddTitleText]?.0 == .시간운동 {
                cell.firstInputType.text = nil
                cell.firstInputField.isHidden = true
                cell.secondInputType.text = "분"
            } else if basicWorkoutData[workoutAddTitleText]?.0 == .무게운동 {
                cell.firstInputType.text = "kg"
                cell.secondInputType.text = "회"
            } else {
                cell.firstInputType.text = nil
                cell.firstInputField.isHidden = true
                cell.secondInputType.text = "회"
            }
            
            cell.backgroundColor = CustomColor.bgGray
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == numberOfSets {
            numberOfSets = numberOfSets + 1
            print(indexPath.row)
            print(numberOfSets)
            workoutAddTable.reloadData()
        }
    }
}
