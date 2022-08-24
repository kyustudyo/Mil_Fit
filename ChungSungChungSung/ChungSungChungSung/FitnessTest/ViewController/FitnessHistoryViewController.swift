//
//  FitnessHistoryViewController.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/08.
//

import UIKit
import Charts
import RealmSwift

class FitnessHistoryViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var sortedButton: UIButton!
    @IBOutlet weak var historyTableView: UITableView!
    
    var index = Int()
    var fitnessRealm: Results<FitnessTestRealm>!
    var resultRealm: Results<FitnessTestRealm>?
    var fitnessRecord = [Double]()
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if index == 0 {
            title = "3km달리기 기록"
        }else if index == 1{
            title = "팔굽혀펴기 기록"
        }else {
            title = "윗몸일으키기 기록"
        }
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = CustomColor.bgGray
        fitnessRealm = localRealm.objects(FitnessTestRealm.self)
        resultRealm = getTargetRealm(data: fitnessRealm, index: index)
        if resultRealm?.count == 0 {
            historyTableView.isHidden = true
            sortedButton.isHidden = true
        }else {
            historyTableView.isHidden = false
            sortedButton.isHidden = false
            historyTableView.dataSource = self
            historyTableView.delegate = self
        }
        fitnessRecord = setChartValue(data: resultRealm)
        lineChartView.noDataText = "기록이 없습니다."
        lineChartView.noDataFont = UIFont.systemFont(ofSize: 17)
        lineChartView.fitScreen()
        lineChartView.backgroundColor = .systemGray6
        lineChartView.layer.cornerRadius = 12
        lineChartView.clipsToBounds = true
        lineChartView.extraTopOffset = 10
        lineChartView.extraLeftOffset = 20
        lineChartView.extraRightOffset = 20
        sortedButton.titleLabel?.textColor = .black
        sortedButton.tintColor = .black
        serChart(lineValues: fitnessRecord)
        configureSortedButton()
    }
    
    func getTargetRealm(data: Results<FitnessTestRealm>, index: Int) -> Results<FitnessTestRealm>? {
        var testType: String = ""
        switch index {
        case 0: testType = "running"
        case 1: testType = "pushup"
        case 2: testType = "situp"
        default: break
        }
        return data.filter("testType == '\(testType)'")
    }
    
    func setChartValue(data: Results<FitnessTestRealm>?) -> [Double] {
        var valueArray: [Double] = []
        if data == nil {
            return valueArray
        }else {
            let data = data!.sorted(byKeyPath: "dateSorting", ascending: true)
            for i in data {
                if i.testType == "running" {
                    let length = String(i.seconds ?? 0).count
                    valueArray.append(Double(i.minutes ?? 0) + (pow(0.1, Double(length))  * Double(i.seconds ?? 0)))
                }else {
                    valueArray.append(Double(i.count!))
                }
            }
            return valueArray
        }
        
    }
    
    func serChart(lineValues: [Double]) {
        if lineValues.isEmpty {
            return
        }
        var lineDataEntries: [ChartDataEntry] = []

        for i in 0..<lineValues.count {
            let lineDataEntry = ChartDataEntry(x: Double(i), y: lineValues[i])
            lineDataEntries.append(lineDataEntry)
        }
        
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        
        var label = ""
        if index == 0 {
            label = "분.초"
        }else {
            label = "회"
        }
        
        let lineChartDataSet = LineChartDataSet(entries: lineDataEntries, label: label)
        lineChartDataSet.colors = [CustomColor.mainPurple!]
        lineChartDataSet.circleColors = [CustomColor.mainPurple!]
        lineChartDataSet.lineWidth = 3
        lineChartDataSet.circleHoleRadius = 3.0
        lineChartDataSet.circleRadius = 5.0
        lineChartDataSet.highlightEnabled = false
 
        let data = LineChartData(dataSet: lineChartDataSet)
        if index != 0 {
            data.setValueFormatter(formatter)
        }
//        data.setValueFont(.systemFont(ofSize: 10))
        data.setValueFont(.systemFont(ofSize: 11, weight: .semibold))
//        lineChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
        lineChartView.data = data
        lineChartView.rightAxis.enabled = false
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.xAxis.enabled = false
        lineChartView.legend.enabled = true
 
        
        lineChartView.backgroundColor = .white
        lineChartView.doubleTapToZoomEnabled = false

    }
    
//    @IBAction func sortedButtonClcked(_ sender: UIButton) {
//    }
//
    func configureSortedButton() {
        let sortedByDate = UIAction(title: "최신순") { _ in
            self.historyTableView.reloadData()
        }
        let sortedByRecord = UIAction(title: "기록순") { _ in
            self.historyTableView.reloadData()
        }
        let buttonMenu = UIMenu(title: "정렬", children: [sortedByDate, sortedByRecord])
        sortedButton.menu = buttonMenu
    }
    
}

extension FitnessHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultRealm?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = historyTableView.dequeueReusableCell(withIdentifier: FitnessHistoryTableViewCell.identifier, for: indexPath) as? FitnessHistoryTableViewCell else { return UITableViewCell() }
        var realm = resultRealm!
        if sortedButton.currentTitle == "최신순" {
            realm = realm.sorted(byKeyPath: "dateSorting", ascending: false)
        }else {
            if index == 0 {
                realm = realm.sorted(byKeyPath: "totalTime", ascending: true)
            }else {
                realm = realm.sorted(byKeyPath: "count", ascending: true)
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        cell.dateLabel.text = "\(dateFormatter.string(from: realm[indexPath.row].date))"
        if index == 0 {
            cell.recordLabel.text = "\(realm[indexPath.row].minutes ?? 0)분 \(realm[indexPath.row].seconds ?? 0)초(\(realm[indexPath.row].level))"
        }else {
            cell.recordLabel.text = "\(realm[indexPath.row].count!)개(\(realm[indexPath.row].level))"
        }
        if realm[indexPath.row].isPractice {
            cell.tagLabel.backgroundColor = CustomColor.blue
            cell.tagLabel.text = "연습"
        }else {
            cell.tagLabel.backgroundColor = CustomColor.red
            cell.tagLabel.text = "정규"
        }
        cell.tagLabel.textColor = .white
        cell.tagLabel.layer.cornerRadius = 3
        cell.tagLabel.clipsToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

