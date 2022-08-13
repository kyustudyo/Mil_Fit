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
    
    var fitnessRecord = [18.0, 17.0, 11.0, 30.0, 21.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        setChart(lineValues: fitnessRecord)
    }
    private func setChart(lineValues: [Double]) {
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
}
