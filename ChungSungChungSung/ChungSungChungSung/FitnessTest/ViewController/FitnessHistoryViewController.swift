//
//  FitnessHistoryViewController.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/08.
//

import UIKit
import Charts

class FitnessHistoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var numbers: [Double] = []
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<numbers.count {
            let value = ChartDataEntry(x: Double(i), y: numbers[i])
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Number")
        line1.colors = [NSUIColor.blue]
        
        let data = LineChartData()
        data.append(line1)
        
        LineChartView.data = data
    }
}
