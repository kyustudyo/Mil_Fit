//
//  FitnessTestStandardViewController.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/08.
//

import UIKit

struct FitnessTestStandard {
    let grade: String
    let record: String
}

class FitnessTestStandardViewController: UIViewController {
    @IBOutlet weak var fitnessTestRunningTableView: UITableView!
    @IBOutlet weak var fitnessTestStandardAge: UILabel!
    var age: Int!
    var fitnessTestStandardRunningList =  [FitnessTestStandard]()
    var fitnessTestStandardPushupList = [FitnessTestStandard]()
    var fitnessTestStandardSitupList =  [FitnessTestStandard]()
    var fitnessTestStandardSports = ["3km 달리기", "팔굽혀펴기", "윗몸일으키기"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "체력검정 기준표"
        navigationItem.largeTitleDisplayMode = .never
//        fitnessTestRunningTableView.layer.shadowColor = UIColor.blue.cgColor
//        fitnessTestRunningTableView.layer.shadowRadius = 20
//        fitnessTestRunningTableView.layer.shadowOffset = CGSize(width: 4, height: 4)
        age = UserDefaults.standard.integer(forKey: "age")
        setStandardData()
    }
    
    func setStandardData() {
        let grade = ["특급", "1급", "2급", "3급", "불합격"]
        for i in grade {
            if i == "특급" {
                fitnessTestStandardRunningList.append(FitnessTestStandard(grade: i, record: "\((getMaxStandard(testType: .running, level: i)) / 60)분 \((getMaxStandard(testType: .running, level: i)) % 60)초 이내"))
                fitnessTestStandardSitupList.append(FitnessTestStandard(grade: i, record: "\(getMinStandard(testType: .situp, level: i))개 이상"))
                fitnessTestStandardPushupList.append(FitnessTestStandard(grade: i, record: "\(getMinStandard(testType: .pushup, level: i))개 이상"))
            }else if i == "불합격" {
                fitnessTestStandardRunningList.append(FitnessTestStandard(grade: i, record: "\((getMinStandard(testType: .running, level: i)) / 60)분 \((getMinStandard(testType: .running, level: i)) % 60)초 이상"))
                fitnessTestStandardSitupList.append(FitnessTestStandard(grade: i, record: "\(getMaxStandard(testType: .situp, level: i))개 이하"))
                fitnessTestStandardPushupList.append(FitnessTestStandard(grade: i, record: "\(getMaxStandard(testType: .pushup, level: i))개 이하"))
            }
            else {
                fitnessTestStandardRunningList.append(FitnessTestStandard(grade: i, record: "\((getMinStandard(testType: .running, level: i)) / 60)분 \((getMinStandard(testType: .running, level: i)) % 60)초 ~ \((getMaxStandard(testType: .running, level: i)) / 60)분 \((getMaxStandard(testType: .running, level: i)) % 60)초"))
                fitnessTestStandardSitupList.append(FitnessTestStandard(grade: i, record: "\(getMinStandard(testType: .situp, level: i))개 ~ \(getMaxStandard(testType: .situp, level: i))개"))
                fitnessTestStandardPushupList.append(FitnessTestStandard(grade: i, record: "\(getMinStandard(testType: .pushup, level: i))개 ~ \(getMaxStandard(testType: .pushup, level: i))개"))
            }
            
        }
    }
}

extension FitnessTestStandardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fitnessTestStandardRunningList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FitnessTestStandardTableViewCell", for: indexPath) as? FitnessTestStandardTableViewCell else { return UITableViewCell() }
        
        var list: [FitnessTestStandard]
        if indexPath.section == 0 {
            list = fitnessTestStandardRunningList
        }else if indexPath.section == 1 {
            list = fitnessTestStandardPushupList
        }else {
            list = fitnessTestStandardSitupList
        }
        cell.textLabel?.text = list[indexPath.row].grade
        cell.detailTextLabel?.text = list[indexPath.row].record
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = fitnessTestStandardSports[section]
        label.font = .systemFont(ofSize: 22, weight: .bold)
        
//        let label2 = UILabel()
//        label2.text = "\(age!)세 기준"
//        label2.font = .preferredFont(forTextStyle: .callout)
//        
//        let stack = UIStackView(arrangedSubviews: [label, label2])
//        label2.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return label
    }
}
