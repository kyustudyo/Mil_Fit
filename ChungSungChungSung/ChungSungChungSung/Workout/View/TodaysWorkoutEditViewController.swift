//
//  TodaysWorkoutEditViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/11.
//

import UIKit

class TodaysWorkoutEditViewController: UIViewController {
    var workoutList: [WorkoutModel] = []
    
    @IBOutlet weak var todaysWorkoutEditTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
}

extension TodaysWorkoutEditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workoutList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todaysWorkoutCell", for: indexPath) as? TodaysWorkoutCell else { return UITableViewCell() }
        
        let workout = workoutList[indexPath.row]
        cell.todayWorkoutTitle.text = workout.title
        
        return cell
    }
}
