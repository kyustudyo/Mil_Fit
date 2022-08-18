//
//  WorkoutListEditViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/12.
//

import UIKit

class WorkoutListEditViewController: UIViewController {
    private let defaults = UserDefaults.standard
    private var favoriteWorkouts: [String]?
    private var otherWorkouts: [String]?
    
    private var workoutList = WorkoutData().list
    var favoriteWorkout: [WorkoutModel] = []
    var notFavoriteWorkout: [WorkoutModel] = []
    private var workout: WorkoutModel?
    
//    @IBOutlet weak var cancelEditingButton: UIBarButtonItem!
    @IBOutlet weak var doneEditingButton: UIBarButtonItem!
    @IBOutlet weak var workoutListEditTable: UITableView!
    
//    @IBAction func cancelEditing(_ sender: Any) {
//        self.presentingViewController?.dismiss(animated: true)
//    }
    //TODO: 기능
    @IBAction func doneEditing(_ sender: Any) {
        defaults.set(favoriteWorkouts, forKey: "WorkoutList")
        defaults.set(otherWorkouts, forKey: "OtherWorkoutList")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = CustomColor.bgGray
//        cancelEditingButton.tintColor = CustomColor.mainPurple
        doneEditingButton.tintColor = CustomColor.mainPurple
        
        workoutListEditTable.backgroundColor = .clear
        workoutListEditTable.setEditing(true, animated: true)
    
        favoriteWorkouts = defaults.stringArray(forKey: "WorkoutList")
        otherWorkouts = defaults.stringArray(forKey: "OtherWorkoutList")
        print("즐겨찾기 \(favoriteWorkouts?.count)")
        print("그 외 목록 \(otherWorkouts?.count)")
    }
}

extension WorkoutListEditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnRows = Int()
        
        if section == 0 {
            if let favoriteWorkouts = favoriteWorkouts {
                returnRows = favoriteWorkouts.count
            }
        } else if section == 1 {
            if let otherWorkouts = otherWorkouts {
                returnRows = otherWorkouts.count
            }
        }
        return returnRows
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var returnTitle = String()
        
        if section == 0 {
            returnTitle = "운동 목록에 포함된 항목"
        } else if section == 1 {
            returnTitle = "그 외 운동 목록"
        }
        return returnTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutListEditCell", for: indexPath) as? WorkoutListEditCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            if let favoriteWorkout = favoriteWorkouts?[indexPath.row] {
                cell.workoutInEditListTitle.text = favoriteWorkout
            }
            
//            favoriteWorkout = workoutList.filter {
//                if $0.isFavorite == true {
//                    return true
//                } else {
//                    return false
//                }
//            }
//            cell.workoutInEditListTitle.text = favoriteWorkout[indexPath.row].title
        
        } else if indexPath.section == 1 {
            if let otherWorkout = otherWorkouts?[indexPath.row] {
                cell.workoutInEditListTitle.text = otherWorkout
            }
//
//            notFavoriteWorkout = workoutList.filter {
//                if $0.isFavorite == false {
//                    return true
//                } else {
//                    return false
//                }
//            }
//            cell.workoutInEditListTitle.text = notFavoriteWorkout[indexPath.row].title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 {
            return .delete
        } else {
            return .insert
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if let targetWorkout = favoriteWorkouts?[indexPath.row] {
        
            if editingStyle == UITableViewCell.EditingStyle.delete {
                if let targetWorkout = favoriteWorkouts?[indexPath.row] {
                
                    favoriteWorkouts?.remove(at: indexPath.row)
                    otherWorkouts?.insert(targetWorkout, at: 0)
                }
        
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//                tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
//                tableView.reloadData()
            } else if editingStyle == UITableViewCell.EditingStyle.insert {
                if let targetWorkout = otherWorkouts?[indexPath.row] {
                
                    otherWorkouts?.remove(at: indexPath.row)
                    favoriteWorkouts?.append(targetWorkout)
                }
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//                if let favoriteWorkoutCount = favoriteWorkouts?.count {
//                    tableView.insertRows(at: [IndexPath(row: favoriteWorkoutCount-1, section: 0)], with: .automatic)
//                }
//                tableView.reloadData()
            }
            tableView.reloadData()
//            workoutListEditTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section == 0 {
            if let targetWorkout = favoriteWorkouts?[sourceIndexPath.row] {
                favoriteWorkouts?.remove(at: sourceIndexPath.row)
                favoriteWorkouts?.insert(targetWorkout, at: destinationIndexPath.row)
            }
//            let targetCell = favoriteWorkout[sourceIndexPath.row]
//            favoriteWorkout.remove(at: sourceIndexPath.row)
//            favoriteWorkout.insert(targetCell, at: destinationIndexPath.row)
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            return false
        } else {
            return true
        }
    }
}
