//
//  WorkoutListEditViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/12.
//

import UIKit

class WorkoutListEditViewController: UIViewController {
    private var workoutList = WorkoutData().list
    var favoriteWorkout: [WorkoutModel] = []
    var notFavoriteWorkout: [WorkoutModel] = []
    private var workout: WorkoutModel?
    
    @IBOutlet weak var cancelEditingButton: UIBarButtonItem!
    @IBOutlet weak var doneEditingButton: UIBarButtonItem!
    @IBOutlet weak var workoutListEditTable: UITableView!
    
    @IBAction func cancelEditing(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = CustomColor.bgGray
        cancelEditingButton.tintColor = CustomColor.mainPurple
        doneEditingButton.tintColor = CustomColor.mainPurple
        
        workoutListEditTable.backgroundColor = .clear
        workoutListEditTable.setEditing(true, animated: true)
    }
}

extension WorkoutListEditViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnRows = Int()
        
        if section == 0 {
            let sectionRows = workoutList.filter { $0.isFavorite == true }.count
            returnRows = sectionRows
        } else if section == 1 {
            let sectionRows = workoutList.filter { $0.isFavorite == false }.count
            returnRows = sectionRows
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
            favoriteWorkout = workoutList.filter {
                if $0.isFavorite == true {
                    return true
                } else {
                    return false
                }
            }
            cell.workoutInEditListTitle.text = favoriteWorkout[indexPath.row].title
        
        } else if indexPath.section == 1 {
            notFavoriteWorkout = workoutList.filter {
                if $0.isFavorite == false {
                    return true
                } else {
                    return false
                }
            }
            cell.workoutInEditListTitle.text = notFavoriteWorkout[indexPath.row].title
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
        if editingStyle == UITableViewCell.EditingStyle.delete {
            favoriteWorkout.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else {
            
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section == 0 {
            let targetCell = favoriteWorkout[sourceIndexPath.row]
            favoriteWorkout.remove(at: sourceIndexPath.row)
            favoriteWorkout.insert(targetCell, at: destinationIndexPath.row)
        }
        // TODO: 그 외 운동 목록(section == 1)은 이동 안되게 하고싶음..
    }
}
