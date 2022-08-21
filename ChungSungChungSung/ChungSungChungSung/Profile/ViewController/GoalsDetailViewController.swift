//
//  GoalsDetailViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/14.
//

import UIKit
import RealmSwift
class GoalsDetailViewController: UIViewController {
    @IBOutlet weak var segCon: UISegmentedControl!
    private var goalList: Results<ToDoListRealm>?
    
    var doneTodos: Results<ToDoListRealm>? = RealmManager.doneTodoData2()
    var notDoneTodos:  Results<ToDoListRealm>? = RealmManager.notDoneTodoData2()
    
//    func fetchTodos(completion: @escaping () -> ()) {
//        doneTodos = RealmManager.doneTodoData2()
//        notDoneTodos = RealmManager.notDoneTodoData2()
//        completion()
//    }
    @IBAction func segconChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
//            if let notDoneTodos = notDoneTodos {
                goalList = notDoneTodos
            print(goalList?.count)
//            } else {
//                goalList = Results
//            }
            goalsDetailTableView.reloadData()
        case 1:
//            if let doneTodos = doneTodos {
                goalList = doneTodos
            print(goalList?.count)
            goalsDetailTableView.reloadData()
        default: break
        }
    }
    
    @IBOutlet weak var goalsDetailTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        goalList = notDoneTodos
        navigationConfig()
        self.view.backgroundColor = CustomColor.bgGray
        goalsDetailTableView.backgroundColor = CustomColor.bgGray
//        goalsDetailTableView.contentInset.top = 10
        
        self.navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        self.navigationItem.title = "목표"
    }
    
    private func navigationConfig() {
        let editButton = UIButton()
        let editImage = UIImage(systemName: "text.badge.minus")
        editButton.setImage(editImage, for: .normal)
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    
        let plusButton = UIButton()
        let plusImage = UIImage(systemName: "plus")
        plusButton.setImage(plusImage, for: .normal)
        plusButton.addTarget(self, action: #selector(goAddGoalViewController), for: .touchUpInside)
        
        let editBarButton = UIBarButtonItem(customView: editButton)
        let plusBarButton = UIBarButtonItem(customView: plusButton)
        self.navigationItem.rightBarButtonItems = [plusBarButton, editBarButton]
    }
    
    @objc private func didTapEditButton() {
        
        goalsDetailTableView.setEditing(goalsDetailTableView.isEditing ? false : true, animated: true)
    }
    @objc private func goAddGoalViewController() {
        let sb = UIStoryboard(name: "TodoListAdd", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "TodoListAddProfileViewController") as? TodoListAddProfileViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GoalsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let goalList = goalList {
            print("qwe", goalList.count)
            return goalList.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalsDetailCell", for: indexPath) as? GoalsDetailCell else { return UITableViewCell() }
        guard let goalList = goalList else { return GoalsDetailCell() }
            
        cell.backgroundColor = .clear
        
        cell.cellRectangle.layer.cornerRadius = 20
        cell.cellRectangle.layer.shadowColor = UIColor.systemGray6.cgColor
        cell.cellRectangle.layer.shadowRadius = 20
        cell.cellRectangle.layer.shadowOpacity = 1
        
        cell.goalLabel.text = goalList[indexPath.row].content
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        cell.goalSavedDateLabel.text = dateFormatter.string(from: goalList[indexPath.row].date)

        if goalList[indexPath.row].isDone == true {
            cell.achievedButton.tintColor = CustomColor.mainPurple
        } else {
            cell.achievedButton.tintColor = .systemGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        goalList.remove(at: indexPath.row)
//        goalsDetailTableView.deleteRows(at: [indexPath], with: .automatic)
//    }
//}

