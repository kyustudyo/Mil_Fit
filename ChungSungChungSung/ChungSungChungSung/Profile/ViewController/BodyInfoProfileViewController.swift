//
//  BodyInfoProfileViewController.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/13.
//

import UIKit
import Charts
import RealmSwift

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
    var weightRecord: [Double]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let localRealm = try! Realm()
        let weightRealm = localRealm.objects(WeightRealm.self).sorted(byKeyPath: "dateSorting", ascending: true)
        drawUI()
        weightRecord = setChartData(data: weightRealm)
        setChart(lineValues: weightRecord)
        ageTextField.text = "\(info[0])"
        heightTextField.text = "\(info[1])"
        weightTextField.text = "\(info[2])"

        
        let completeBarButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeEdit))
        self.navigationItem.rightBarButtonItems = [completeBarButton]
    }
    
    func setChartData(data: Results<WeightRealm>) -> [Double] {
        var dataSet = [Double]()
        for i in data {
            dataSet.append(Double(i.weight))
        }
        return dataSet
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
        lineChartDataSet.highlightEnabled = false
        let data = LineChartData(dataSet: lineChartDataSet)
        weightGraphView.data = data
        weightGraphView.rightAxis.enabled = false
        weightGraphView.drawGridBackgroundEnabled = false
        weightGraphView.leftAxis.enabled = false
        weightGraphView.xAxis.enabled = false
        weightGraphView.legend.enabled = false
        weightGraphView.backgroundColor = .white
        weightGraphView.layer.cornerRadius = 12
        weightGraphView.clipsToBounds = true
        weightGraphView.extraTopOffset = 10
        weightGraphView.extraLeftOffset = 20
        weightGraphView.extraRightOffset = 20
        weightGraphView.doubleTapToZoomEnabled = false
    }
}

protocol EditBodyViewRelatedForBodyVC: AnyObject {
    func completeEdit()
}


