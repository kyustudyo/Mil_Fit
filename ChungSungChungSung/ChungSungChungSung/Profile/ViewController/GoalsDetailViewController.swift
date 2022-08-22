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
    
//    guard let workoutAddView = UIStoryboard(name: "WorkoutAdd", bundle: .main).instantiateViewController(withIdentifier: "WorkoutAddViewController") as? WorkoutAddViewController else { return }
    var lists: [ToDoListRealm] = []
    weak var delegate: TodoAdd?
    
    weak var deleteDelegate: DeleteTodo?
    
    var doneTodos: Results<ToDoListRealm>? = RealmManager.doneTodoData2()
    var notDoneTodos:  Results<ToDoListRealm>? = RealmManager.notDoneTodoData2()
    
    @IBAction func segconChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            if let notDoneTodos = RealmManager.notDoneTodoData2() {
                lists = Array(notDoneTodos)
            } else {
                lists = []
            }
            goalsDetailTableView.reloadData()
        case 1:
            if let doneTodos = RealmManager.doneTodoData2() {
                lists = Array(doneTodos)
            } else {
                lists = []
            }
            goalsDetailTableView.reloadData()
        default: break
        }
    }
    
    @IBOutlet weak var goalsDetailTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let notDoneTodos = notDoneTodos {
             lists = Array(notDoneTodos)
        }
        
        navigationConfig()
        self.view.backgroundColor = CustomColor.bgGray
        goalsDetailTableView.backgroundColor = CustomColor.bgGray
        
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
        plusButton.addTarget(self, action: #selector(goAddTodoVC), for: .touchUpInside)
        
        let editBarButton = UIBarButtonItem(customView: editButton)
        let plusBarButton = UIBarButtonItem(customView: plusButton)
        self.navigationItem.rightBarButtonItems = [plusBarButton, editBarButton]
    }
    
    @objc private func didTapEditButton() {
        
        goalsDetailTableView.setEditing(goalsDetailTableView.isEditing ? false : true, animated: true)
    }
    @objc private func goAddTodoVC() {
        guard let vc = UIStoryboard(name: "TodoListAdd", bundle: .main).instantiateViewController(withIdentifier: "TodoListAddProfileViewController") as? TodoListAddProfileViewController else { return }
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GoalsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("qqqq", lists.count)
            return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalsDetailCell", for: indexPath) as? GoalsDetailCell else { return UITableViewCell() }
//        guard let goalList = goalList else { return GoalsDetailCell() }
            
        cell.backgroundColor = .clear
        
        cell.cellRectangle.layer.cornerRadius = 20
        cell.cellRectangle.layer.shadowColor = UIColor.systemGray6.cgColor
        cell.cellRectangle.layer.shadowRadius = 20
        cell.cellRectangle.layer.shadowOpacity = 1
//        cell.goalID = goalList[indexPath.row].dateSorting
        cell.goalID = lists[indexPath.row].dateSorting
        cell.goalLabel.text = lists[indexPath.row].content
        cell.delegate = self
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        cell.goalSavedDateLabel.text = dateFormatter.string(from: lists[indexPath.row].date)

        if lists[indexPath.row].isDone == true {
            cell.achievedButton.tintColor = CustomColor.mainPurple
        } else {
            cell.achievedButton.tintColor = .systemGray
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            RealmManager.deleteTodo(id: lists[indexPath.row].dateSorting)
            lists.remove(at: indexPath.row)
            goalsDetailTableView.deleteRows(at: [indexPath], with: .automatic)
            deleteDelegate?.didDelete()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}
extension GoalsDetailViewController: TodoDone {
    func changeTodoDone(id: Int?) {
        if let id = id {
            RealmManager.changeTodoDone(id: id)
        }
        
        doneTodos = RealmManager.doneTodoData2()
        notDoneTodos = RealmManager.notDoneTodoData2()
        
        updateTableview()
        
        
//        if segCon.selectedSegmentIndex == 0 {
//            if let notDoneTodos = notDoneTodos {
////                goalList = notDoneTodos
//                lists = Array(notDoneTodos)
//            }
//        } else {
//            if let doneTodos = doneTodos {
////                goalList = notDoneTodos
//                lists = Array(doneTodos)
//            }
//        }
//        goalsDetailTableView.reloadData()
    }
}

extension GoalsDetailViewController {
    private func updateTableview() {
        if segCon.selectedSegmentIndex == 0 {
            if let notDoneTodos = RealmManager.notDoneTodoData2() {
                lists = Array(notDoneTodos)
            } else {
                lists = []
            }
        }
        else {
            if let doneTodos = RealmManager.doneTodoData2() {
                lists = Array(doneTodos)
            } else {
                lists = []
            }
        }
        goalsDetailTableView.reloadData()
    }
}
extension RealmManager {
    
    static func deleteTodo(id: Int){
    let realm = try! Realm()
    let predicate = NSPredicate(format: "dateSorting == %@", NSNumber(value: id))
    if let firstItem = realm.objects(ToDoListRealm.self)
                            .filter(predicate)
                            .first {
                            try! realm.write {
                                realm.delete(firstItem)
                            }
                        }
    }
    
    static func changeTodoDone(id: Int) {
        let localRealm = try! Realm()
        let predicate = NSPredicate(format: "dateSorting == %@", NSNumber(value: id))
        let realms = localRealm.objects(ToDoListRealm.self)
                               .filter(predicate)
       for tiger in realms {
           try! localRealm.write {
               tiger.isDone.toggle()
           }
       }
    }
}

extension GoalsDetailViewController: TodoAdd {
    func addTodo() {
        segCon.selectedSegmentIndex = 0
        updateTableview()
        delegate?.addTodo()
    }
}


protocol DeleteTodo: AnyObject {
    func didDelete()
}
