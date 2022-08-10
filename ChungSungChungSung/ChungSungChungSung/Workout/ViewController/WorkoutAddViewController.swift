//
//  WorkoutAddViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/06.
//

import UIKit

class WorkoutAddViewController: UIViewController {
    private let numberOfRows: Int = 5
    private var estimatedCalorie: Double = 0
    
    var workout: WorkoutModel?
    
    @IBOutlet weak var workoutAddTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        workoutAddTable.delegate = self
//        workoutAddTable.dataSource = self
        
        let workoutAddTwoTableViewCellNib = UINib(nibName: "WorkoutAddTwoTableViewCell", bundle: nil)
        let workoutAddOneTableViewCellNib = UINib(nibName: "WorkoutAddOneTableViewCell", bundle: nil)
        let workoutAddPlusTableViewCellNib = UINib(nibName: "WorkoutAddPlusTableViewCell", bundle: nil)
        let workoutAddCalorieTableViewCellNib = UINib(nibName: "WorkoutAddCalorieTableViewCell", bundle: nil)
        
        workoutAddTable.register(workoutAddTwoTableViewCellNib, forCellReuseIdentifier: "workoutAddTwoTableViewCell")
        workoutAddTable.register(workoutAddOneTableViewCellNib, forCellReuseIdentifier: "workoutAddOneTableViewCell")
        workoutAddTable.register(workoutAddPlusTableViewCellNib, forCellReuseIdentifier: "workoutAddPlusTableViewCell")
        workoutAddTable.register(workoutAddCalorieTableViewCellNib, forCellReuseIdentifier: "workoutAddCalorieTableViewCell")
    }
}

extension WorkoutAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == numberOfRows {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddCalorieTableViewCell", for: indexPath) as? WorkoutAddCalorieTableViewCell else {
                return UITableViewCell()
            }
            
            cell.estimatedCalorieView.text = "추정 칼로리: \(estimatedCalorie) kcal"

            return cell
        } else if (indexPath.row == numberOfRows - 1) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddPlusTableViewCell", for: indexPath) as? WorkoutAddPlusTableViewCell else {
                return UITableViewCell()
            }

            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddTwoTableViewCell", for: indexPath) as? WorkoutAddTwoTableViewCell else {
                return UITableViewCell()
            }
        
            let setNumber = indexPath.row + 1
            cell.setNumberView.text = "\(setNumber)세트"
            
            if let workout = workout {
                if let firstInput = workout.firstInputType {
                    cell.firstInputType.text = firstInput
                } else {
                    cell.firstInputField.isHidden = true
                }
                cell.secondInputType.text = workout.secondInputType
            }
            
            return cell
        }
    }
}
