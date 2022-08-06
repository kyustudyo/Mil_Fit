//
//  WorkoutAddViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/06.
//

import UIKit

class WorkoutAddViewController: UIViewController {
    let numberOfRows: Int = 5
    
    @IBOutlet weak var workoutAddTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        workoutAddTable.delegate = self
        workoutAddTable.dataSource = self
        let workoutAddTwoTableViewCellNib = UINib(nibName: "WorkoutAddTwoTableViewCell", bundle: nil)
        let workoutAddOneTableViewCellNib = UINib(nibName: "WorkoutAddOneTableViewCell", bundle: nil)
        let workoutAddPlusTableViewCellNib = UINib(nibName: "WorkoutAddPlusTableViewCell", bundle: nil)
        
        workoutAddTable.register(workoutAddTwoTableViewCellNib, forCellReuseIdentifier: "workoutAddTwoTableViewCell")
        workoutAddTable.register(workoutAddOneTableViewCellNib, forCellReuseIdentifier: "WorkoutAddOneTableViewCell")
        workoutAddTable.register(workoutAddPlusTableViewCellNib, forCellReuseIdentifier: "WorkoutAddPlusTableViewCell")
    }
}

extension WorkoutAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == numberOfRows {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddPlusTableViewCell", for: indexPath) as? WorkoutAddPlusTableViewCell else {
//                return UITableViewCell()
//            }
//
//            return cell
//        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddTwoTableViewCell", for: indexPath) as? WorkoutAddTwoTableViewCell else {
                return UITableViewCell()
            }
        
            let setNumber = indexPath.row + 1    
            cell.setNumberView.text = "\(setNumber)세트"
            
            return cell
//        }
    }
}
