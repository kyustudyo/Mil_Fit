//
//  BodyInfoProfileViewController.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/13.
//

import UIKit
import Charts

class BodyInfoProfileViewController: UIViewController {

    //저장 버튼
    @IBOutlet weak var weightGraphView: LineChartView!
    @IBOutlet weak var weightGraphLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var ageLabel: UILabel!
    var info: [Int] = []
    weak var delegate: EditBodyViewRelatedForBodyVC?
    var weightRecord = [56.0, 60.0, 76.0, 52.0, 60.0, 76.0, 52.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        drawUI()
        setChart(lineValues: weightRecord)
        ageTextField.text = "\(info[0])"
        heightTextField.text = "\(info[1])"
        weightTextField.text = "\(info[2])"
        
        let completeBarButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeEdit))
        self.navigationItem.rightBarButtonItems = [completeBarButton]
    }
    
    @objc fileprivate func completeEdit() {
        if let age = self.ageTextField.text, age.count != 0 {
            if let iAge = Int(age) {
                UserDefaultManager.saveAge(age: iAge)
            }
        }
        if let weight = self.weightTextField.text, weight.count != 0 {
            if let iWeight = Int(weight) {
                RealmManager.saveWeightData(date: Date().addingTimeInterval(60*60*9), weight: iWeight)
                print("chch", Date().addingTimeInterval(60*60*9))
            }
        }
        if let height = self.heightTextField.text, height.count != 0 {
            if let iHeight = Int(height) {
                UserDefaultManager.saveHeight(height: iHeight)
            }
        }

        delegate?.completeEdit()
        navigationController?.popViewController(animated: true)
    }
    
    private func drawUI(){
        view.backgroundColor = CustomColor.bgGray
        ageLabel.text = "나이"
        ageTextField.layer.cornerRadius = 12
        heightLabel.text = "키(cm)"
        heightTextField.layer.cornerRadius = 12
        weightLabel.text = "체중(kg)"
        weightTextField.layer.cornerRadius = 12
        weightGraphLabel.text = "신체 변화 그래프"
        
        
    }
    private func setChart(lineValues: [Double]) {
        var lineDataEntries: [ChartDataEntry] = []

        for i in 0..<lineValues.count {
            let lineDataEntry = ChartDataEntry(x: Double(i), y: lineValues[i])
            lineDataEntries.append(lineDataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: lineDataEntries, label: "체중")
        lineChartDataSet.colors = [CustomColor.mainPurple!]
        lineChartDataSet.circleColors = [CustomColor.mainPurple!]
        lineChartDataSet.lineWidth = 3
        lineChartDataSet.circleHoleRadius = 3.0
        lineChartDataSet.circleRadius = 5.0
        
        let data = LineChartData(dataSet: lineChartDataSet)
        weightGraphView.data = data
        weightGraphView.rightAxis.enabled = false
        weightGraphView.drawGridBackgroundEnabled = false
//        lineChartView.leftAxis.enabled = false
        weightGraphView.xAxis.enabled = false
        weightGraphView.legend.enabled = false
        weightGraphView.backgroundColor = .white
    }
}

protocol EditBodyViewRelatedForBodyVC: AnyObject {
    func completeEdit()
}


