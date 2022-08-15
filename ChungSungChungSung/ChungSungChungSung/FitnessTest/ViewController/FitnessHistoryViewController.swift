//
//  FitnessHistoryViewController.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/08.
//

import UIKit
import Charts

class FitnessHistoryViewController: UIViewController {
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var sortedButton: UIButton!
    @IBOutlet weak var historyTableView: UITableView!
    
    var fitnessRecord = [18.0, 17.0, 11.0, 30.0, 21.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.dataSource = self
        historyTableView.delegate = self
        serChart(lineValues: fitnessRecord)
        configureSortedButton()
    }
    func serChart(lineValues: [Double]) {
        var lineDataEntries: [ChartDataEntry] = []

        for i in 0..<lineValues.count {
            let lineDataEntry = ChartDataEntry(x: Double(i), y: lineValues[i])
            lineDataEntries.append(lineDataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: lineDataEntries, label: "기록")
        lineChartDataSet.colors = [CustomColor.mainPurple!]
        lineChartDataSet.circleColors = [CustomColor.mainPurple!]
        lineChartDataSet.lineWidth = 3
        lineChartDataSet.circleHoleRadius = 3.0
        lineChartDataSet.circleRadius = 5.0
        
        let data = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = data
        lineChartView.rightAxis.enabled = false
        lineChartView.drawGridBackgroundEnabled = false
//        lineChartView.leftAxis.enabled = false
        lineChartView.xAxis.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.backgroundColor = .white
    }
    
    func configureSortedButton() {
        let sortedByDate = UIAction(title: "최신순") { _ in
            print("최신순")
        }
        let sortedByRecord = UIAction(title: "기록순") { _ in
            print("기록순")
        }
        let buttonMenu = UIMenu(title: "정렬", children: [sortedByDate, sortedByRecord])
        sortedButton.menu = buttonMenu
    }
    
}

extension FitnessHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

