//
//  FitnessTestStandardViewController.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/08.
//

import UIKit

struct FitnessTestStandardRunning {
    let grade: String
    let time: String
}

var fitnessTestStandardSports = ["3km 달리기", "팔굽혀펴기", "윗몸일으키기"]
var fitnessTestStandardRunningList = [
    FitnessTestStandardRunning(grade: "특급", time: "12분 30초 이내"),
    FitnessTestStandardRunning(grade: "1급", time: "12분 31초~13분 32초"),
    FitnessTestStandardRunning(grade: "2급", time: "13분 33초~14분 34초"),
    FitnessTestStandardRunning(grade: "3급", time: "14분 35초~15분 36초"),
    FitnessTestStandardRunning(grade: "불합격", time: "15분 37초 이상"),
]


class FitnessTestStandardViewController: UIViewController {
    @IBOutlet weak var fitnessTestRunningTableView: UITableView!
    @IBOutlet weak var fitnessTestStandardAge: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fitnessTestRunningTableView.layer.shadowColor = UIColor.blue.cgColor
        fitnessTestRunningTableView.layer.shadowRadius = 20
        fitnessTestRunningTableView.layer.shadowOffset = CGSize(width: 4, height: 4)
        fitnessTestRunningTableView.layer.masksToBounds = false
    }
}

extension FitnessTestStandardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fitnessTestStandardRunningList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessTestStandardTableViewCell", for: indexPath) as? FitnessTestStandardTableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = fitnessTestStandardRunningList[indexPath.row].grade
        cell.detailTextLabel?.text = fitnessTestStandardRunningList[indexPath.row].time
//        cell.layer.shadowColor = UIColor.blue.cgColor
//        cell.layer.shadowRadius = 20
//        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = fitnessTestStandardSports[section]
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }
}
