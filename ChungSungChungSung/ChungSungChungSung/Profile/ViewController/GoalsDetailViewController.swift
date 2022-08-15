//
//  GoalsDetailViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/14.
//

import UIKit

class GoalsDetailViewController: UIViewController {
    private var goalList = GoalData().list
    
    @IBOutlet weak var goalsDetailTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let editBarButton = UIBarButtonItem(customView: editButton)
        let plusBarButton = UIBarButtonItem(customView: plusButton)
        self.navigationItem.rightBarButtonItems = [plusBarButton, editBarButton]
    }
    
    @objc private func didTapEditButton() {
        goalsDetailTableView.setEditing(true, animated: true)
    }
}

extension GoalsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalsDetailCell", for: indexPath) as? GoalsDetailCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        
        cell.goalLabel.text = goalList[indexPath.row].content
        cell.goalSavedDateLabel.text = goalList[indexPath.row].date
        
        cell.cellRectangle.layer.cornerRadius = 20
        cell.cellRectangle.layer.shadowColor = UIColor.systemGray6.cgColor
        cell.cellRectangle.layer.shadowRadius = 20
        cell.cellRectangle.layer.shadowOpacity = 1
        
        if goalList[indexPath.row].isAchieved == true {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        goalList.remove(at: indexPath.row)
        goalsDetailTableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
