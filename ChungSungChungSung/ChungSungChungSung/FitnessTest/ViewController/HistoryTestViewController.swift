//
//  PreviousTestViewController.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/17.
//

import UIKit
import RealmSwift

class HistoryTestViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    var localRealm: Realm!
    var fitnessRealm: Results<FitnessTestRealm>!
    var resultRealm: Results<FitnessTestRealm>!
    var tempArray =  [FitnessTestRealm(), FitnessTestRealm(), FitnessTestRealm()]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem?.title = "편집"
        navigationItem.rightBarButtonItem?.tintColor = CustomColor.mainPurple
        localRealm = try! Realm()
        fitnessRealm = localRealm.objects(FitnessTestRealm.self)
        resultRealm = fitnessRealm.filter("isPractice == false").sorted(byKeyPath: "dateSorting", ascending: false)
        historyTableView.contentInset.top = 10
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        historyTableView.setEditing(editing, animated: animated)
        self.editButtonItem.title = editing ? "완료" : "편집"
    }
    override func viewWillAppear(_ animated: Bool) {
        title = "지난 체력검정 결과"
        navigationItem.largeTitleDisplayMode = .never
    }
    
}

extension HistoryTestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (resultRealm.count / 3)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = historyTableView.dequeueReusableCell(withIdentifier: HistoryTestTableViewCell.identifier, for: indexPath) as? HistoryTestTableViewCell else { return UITableViewCell() }
            for i in 0...2 {
                if resultRealm[indexPath.row * 3 + i].testType == "running" {
                    tempArray[0] = resultRealm[indexPath.row * 3 + i]
                }else if resultRealm[indexPath.row * 3 + i].testType  == "pushup" {
                    tempArray[1] = resultRealm[indexPath.row * 3 + i]
                }else if resultRealm[indexPath.row * 3 + i].testType  == "situp" {
                    tempArray[2] = resultRealm[indexPath.row * 3 + i]
                }
            }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        cell.dateLabel.text = "\(tempArray[0].date)"
        cell.pushupRecordLabel.text = "\(tempArray[1].count!)회(\(tempArray[1].level))"
        cell.situpRecordLabel.text = "\(tempArray[2].count!)회(\(tempArray[2].level))"
        cell.runningRecordLabel.text = "\(tempArray[0].minutes!)분 \(tempArray[0].seconds!)초"
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "기록을 삭제하시겠습니까?", message: "해당 기록이 삭제됩니다.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
        let destructiveAction = UIAlertAction(title: "삭제", style: UIAlertAction.Style.destructive) { _ in
            try! self.localRealm.write({
                self.localRealm.delete(self.resultRealm[indexPath.row])
                //                self.localRealm.delete(self.resultRealm[indexPath.row * 3])
                //                self.localRealm.delete(self.resultRealm[indexPath.row * 3 + 1])
                //                self.localRealm.delete(self.resultRealm[indexPath.row * 3 + 2])
            })
            self.historyTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        alert.addAction(cancelAction)
        alert.addAction(destructiveAction)

        self.present(alert, animated: false)
        
    }
    
}
