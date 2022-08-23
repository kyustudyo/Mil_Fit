//
//  SelectArmyViewController.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/14.
//

import UIKit

class SelectArmyViewController: UIViewController {

    let tableView = UITableView()
    //TODO: 기존것 가져가도록
//    var selectedArmyIndex = -1
    var isMealCollectionView = ""
    
    weak var delegate: ArmySelection?
//    weak var delegateInMealView: ArmySelectionInMealView?
    
    var pastViewName: String = "메인"
    
    let totalArmy = ["제5322부대", "제6282부대", "제8623부대", "제7369부대", "제8902부대", "제9030부대", "제5021부대", "제3389부대", "제1691부대", "제2171부대", "제6335부대", "제1575부대", "제2291부대", "제3182부대", "제2621부대", "제5397부대", "제7162부대", "제3296부대", "제6176부대", "제1862부대", "없음"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SelectArmyTableViewCell.self, forCellReuseIdentifier: SelectArmyTableViewCell.cellID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 16
        tableView.tableHeaderView = UIView()
        
        
//        self.view.backgroundColor = .blue
        view.backgroundColor = CustomColor.bgGray
        navigationItem.title = "부대 선택"
        navigationController?.navigationBar.topItem?.backButtonTitle = pastViewName
//        view.backgroundColor = .systemGray6
        let confirmArmyChangeButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(confirmArmyChange))
        self.navigationItem.rightBarButtonItems = [confirmArmyChangeButton]
        self.navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
        // Do any additional setup after loading the view.
    }
    
    @objc fileprivate func confirmArmyChange() {
//        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
//        isMealCollectionView = totalArmy[indexPath.row]
//        tableView.deselectRow(at: indexPath, animated: true)
//        tableView.reloadData()
        delegate?.selectArmy(selectedArmy: isMealCollectionView)
//        delegateInMealView?.selectArmy(selectedArmy: isMealCollectionView)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

}
extension SelectArmyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalArmy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectArmyTableViewCell.cellID, for: indexPath) as? SelectArmyTableViewCell else { return UITableViewCell() }
        cell.armyLabel.text = totalArmy[indexPath.row]
        cell.separatorInset = (indexPath.row == totalArmy.count - 1) ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width) : UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cell.accessoryType = totalArmy[indexPath.row] == isMealCollectionView ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        selectedArmyIndex = indexPath
        isMealCollectionView = totalArmy[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
//        delegate?.selectArmy(selectedArmy: isMealCollectionView)
    }
    
}

protocol ArmySelection: AnyObject {
    func selectArmy(selectedArmy: String)
}

//protocol ArmySelectionInMealView: AnyObject {
//    func selectArmy(selectedArmy: String)
//}
