//
//  TodaysWorkoutEditViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/11.
//

import UIKit
import RealmSwift

class TodaysWorkoutEditViewController: UIViewController {
    let didDismissTodaysWorkoutEditView: Notification.Name = Notification.Name("DidDismissTodaysWorkoutEditView")
    
    var workoutList: [WorkoutModel] = []
    
    var selectedDateString: String?
    var workoutRealm: Results<WorkoutRealm>!
    weak var delegate: WorkoutEdit?
//    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var todaysWorkoutEditTable: UITableView!
    
//    @IBAction func cancel(_ sender: Any) {
//        self.presentingViewController?.dismiss(animated: true)
//    }
    //TODO: 기능
    @IBAction func doneEditing(_ sender: Any) {
        NotificationCenter.default.post(name: didDismissTodaysWorkoutEditView, object: nil, userInfo: nil)
        delegate?.needUpdate()
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = CustomColor.bgGray
        doneButton.tintColor = CustomColor.mainPurple
        
        todaysWorkoutEditTable.backgroundColor = .clear
        todaysWorkoutEditTable.setEditing(true, animated: true)
    }
}

extension TodaysWorkoutEditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnNumber = Int()
        
        if let selectedDateString = selectedDateString {
            let todaysWorkout = workoutRealm.where {
                $0.dateSearching == selectedDateString && $0.set == 1
            }
            returnNumber = todaysWorkout.count
        }
        return returnNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todaysWorkoutEditCell", for: indexPath) as? TodaysWorkoutEditCell else { return UITableViewCell() }
//        let workout = workoutList[indexPath.row]
//        cell.todaysWorkoutTitle.text = workout.title
        
        if let selectedDateString = selectedDateString {
            let todaysWorkout = workoutRealm.where {
                $0.dateSearching == selectedDateString && $0.set == 1
            }
            cell.todaysWorkoutTitle.text = todaysWorkout[indexPath.row].name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        workoutList.remove(at: indexPath.row)
        
        if let selectedDateString = selectedDateString {
            let todaysWorkout = workoutRealm.where {
                $0.dateSearching == selectedDateString && $0.set == 1
            }
            let workoutName = todaysWorkout[indexPath.row].name
            RealmManager.deleteWorkoutData(name: workoutName, selectedDate: selectedDateString)
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let targetCell = workoutList[sourceIndexPath.row]
//        workoutList.remove(at: sourceIndexPath.row)
//        workoutList.insert(targetCell, at: destinationIndexPath.row)
//    }
}

protocol WorkoutEdit: AnyObject {
    func needUpdate()
}
