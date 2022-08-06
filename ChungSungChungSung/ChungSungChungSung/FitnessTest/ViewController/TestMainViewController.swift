//
//  TestMainViewController.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/06.
//

import UIKit

class TestMainViewController: UIViewController {
    
    //그래프안에 Label

    @IBOutlet weak var fitnessGraphButton: UIButton!
    
    @IBOutlet weak var graphRoundedRectangleView: UIView!
    @IBOutlet weak var historyFitnessTestLabel: UILabel!
    @IBOutlet weak var lastFitnessTestDateLabel: UILabel!
    @IBOutlet weak var goToHistoryLabel: UILabel!
    
    @IBOutlet weak var runningGraphView: UIView!
    @IBOutlet weak var runningGraphTitleLabel: UILabel!
    @IBOutlet weak var runningGraphRecordLabel: UILabel!
    
    @IBOutlet weak var pushupGraphView: UIView!
    @IBOutlet weak var pushupGraphTitleLabel: UILabel!
    @IBOutlet weak var pushupGraphRecordLabel: UILabel!
    
    @IBOutlet weak var situpGraphView: UIView!
    @IBOutlet weak var situpGraphTitleLabel: UILabel!
    @IBOutlet weak var situpGraphRecordLabel: UILabel!
    
    
    @IBOutlet weak var recordTableViewTitleLabel: UILabel!

    @IBOutlet weak var fitnessMainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fitnessMainTableView.dataSource = self
        fitnessMainTableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "체력검정"
        let standardButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: "didTapStandardButton")
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: "didTapAddButton")
        navigationItem.rightBarButtonItems = [standardButton, addButton]
        fitnessGraphButton.tintColor = UIColor.clear
        fitnessGraphButton.titleLabel?.text = ""
        drawGraphViewRectangleUI()
        drawTableViewUI()
    }
    
    func drawGraphViewRectangleUI() {
        graphRoundedRectangleView.layer.cornerRadius = 20
        graphRoundedRectangleView.backgroundColor = UIColor.systemGray //
        historyFitnessTestLabel.text = "지난 체력검정 결과"
        historyFitnessTestLabel.textColor = UIColor.gray //
        lastFitnessTestDateLabel.text = "2022.08.07"//
        lastFitnessTestDateLabel.textColor = UIColor.gray //
        goToHistoryLabel.text = "􀆊"
        goToHistoryLabel.textColor = UIColor.gray //
        runningGraphView.backgroundColor = UIColor.clear
        runningGraphTitleLabel.text = "1.5Km 달리기"
        runningGraphTitleLabel.textColor = UIColor.gray //
        runningGraphRecordLabel.text = "12:30/12:30" //
        runningGraphRecordLabel.textColor = UIColor.gray //
        pushupGraphView.backgroundColor = UIColor.clear
        pushupGraphTitleLabel.text = "팔굽혀펴기"
        pushupGraphTitleLabel.textColor = UIColor.gray //
        pushupGraphRecordLabel.text = "70개/72개" //
        pushupGraphRecordLabel.textColor = UIColor.gray //
        situpGraphView.backgroundColor = UIColor.clear
        situpGraphTitleLabel.text = "윗몸 일으키기"
        situpGraphTitleLabel.textColor = UIColor.gray //
        situpGraphRecordLabel.text = "80회/86회"//
        situpGraphRecordLabel.textColor = UIColor.gray //
        }
    func drawTableViewUI() {
        recordTableViewTitleLabel.text = "종목별 최고 기록"
        //폰트크기
    }
}

extension TestMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = fitnessMainTableView.dequeueReusableCell(withIdentifier: TestMainTableViewCell.identifier, for: indexPath) as? TestMainTableViewCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            cell.fitnessTitleLabel.text = "1.5km 달리기"
            cell.fitnessRecordDateLabel.text = "2022.03.31" //
            cell.fitnessRecordLabel.text = "12분 30초(2급)" //
            cell.fitnessImageView.backgroundColor = UIColor.red //
        }else if indexPath.row == 1 {
            cell.fitnessTitleLabel.text = "팔굽혀펴기"
            cell.fitnessRecordDateLabel.text = "2022.03.30" //
            cell.fitnessRecordLabel.text = "40회(2급)" //
            cell.fitnessImageView.backgroundColor = UIColor.purple //
        }else {
            cell.fitnessTitleLabel.text = "윗몸일으키기"
            cell.fitnessRecordDateLabel.text = "2022.03.29" //
            cell.fitnessRecordLabel.text = "85회(특급)" //
            cell.fitnessImageView.backgroundColor = UIColor.blue //
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
