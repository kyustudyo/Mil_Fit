//
//  WorkoutAddViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/06.
//

import UIKit

class WorkoutAddViewController: UIViewController {
    
    @IBOutlet weak var workoutAddTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let workoutAddTwoTableViewCellNib = UINib(nibName: "WorkoutAddTwoTableViewCell", bundle: nil)
        workoutAddTable.register(workoutAddTwoTableViewCellNib, forCellReuseIdentifier: "workoutAddTwoTableViewCell")
    }
}

extension WorkoutAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutAddTwoTableViewCell", for: indexPath) as? WorkoutAddTwoTableViewCell else {
            return UITableViewCell()
        }
        let setNumber = indexPath.row + 1
        
        cell.setNumberView.text = "\(setNumber)세트"
        
        return cell
    }
}
