//
//  TestMainViewController.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/06.
//

import UIKit
import SwiftUI
import Charts

class TestMainViewController: UIViewController {
    
    //그래프안에 Label

    @IBOutlet weak var fitnessGraphButton: UIButton!
    
    @IBOutlet weak var graphRoundedRectangleView: UIView!
    @IBOutlet weak var historyFitnessTestLabel: UILabel!
    @IBOutlet weak var lastFitnessTestDateLabel: UILabel!
    @IBOutlet weak var goToHistoryImageView: UIImageView!
    
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
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "체력검정"
//        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fitnessMainTableView.dataSource = self
        fitnessMainTableView.delegate = self
        
        let standardButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(didTapStandardButton))
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItems = [standardButton, addButton]
        
        fitnessGraphButton.tintColor = UIColor.clear
        fitnessGraphButton.titleLabel?.text = ""
        
        drawGraphViewRectangleUI()
        drawTableViewUI()
        configureRunningGraphView()
        configurePushupGraphView()
        configureSitupGraphView()
    }
    //TODO: 어딨지
    @objc fileprivate func didTapStandardButton() {
        let sb = UIStoryboard(name: "TestStoryboard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "HistoryTestViewController") as? HistoryTestViewController else {return}
    }
    @objc fileprivate func didTapAddButton() {
        let sb = UIStoryboard(name: "FitnessTestAddStoryboard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "FitnessTestAdd") as? FitnessTestAddViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func tapHistoryTestButton(_ sender: UIButton) {
        let sb = UIStoryboard(name: "TestStoryboard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "HistoryTestViewController") as? HistoryTestViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
    }
    func drawGraphViewRectangleUI() {
        graphRoundedRectangleView.layer.cornerRadius = 20
        graphRoundedRectangleView.backgroundColor = CustomColor.bgGray //
        historyFitnessTestLabel.text = "지난 체력검정 결과"
        historyFitnessTestLabel.textColor = UIColor.gray //
        lastFitnessTestDateLabel.text = "2022.08.07"//
        lastFitnessTestDateLabel.textColor = UIColor.gray //
        goToHistoryImageView.image = UIImage(systemName: "chevron.right")
        goToHistoryImageView.tintColor = UIColor.gray //
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
    func configureRunningGraphView() {
    let controller = UIHostingController(rootView: RunningGraphSwiftUIView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    runningGraphView.addSubview(controller.view)
    NSLayoutConstraint.activate([
        controller.view.widthAnchor.constraint(equalTo: runningGraphView.widthAnchor, multiplier: 0.6),
        controller.view.heightAnchor.constraint(equalTo: runningGraphView.widthAnchor, multiplier: 0.6),
        controller.view.centerXAnchor.constraint(equalTo: runningGraphView.centerXAnchor),
        controller.view.centerYAnchor.constraint(equalTo: runningGraphView.centerYAnchor)
    ])
    }
    
    func configurePushupGraphView() {
    let controller = UIHostingController(rootView: PushupGraphSwiftUIView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    pushupGraphView.addSubview(controller.view)
    NSLayoutConstraint.activate([
        controller.view.widthAnchor.constraint(equalTo: pushupGraphView.widthAnchor, multiplier: 0.6),
        controller.view.heightAnchor.constraint(equalTo: pushupGraphView.widthAnchor, multiplier: 0.6),
        controller.view.centerXAnchor.constraint(equalTo:pushupGraphView.centerXAnchor),
        controller.view.centerYAnchor.constraint(equalTo: pushupGraphView.centerYAnchor)
    ])
    }
    
    func configureSitupGraphView() {
    let controller = UIHostingController(rootView: SitupGraphSwiftUIView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    situpGraphView.addSubview(controller.view)
    NSLayoutConstraint.activate([
        controller.view.widthAnchor.constraint(equalTo: situpGraphView.widthAnchor, multiplier: 0.6),
        controller.view.heightAnchor.constraint(equalTo: situpGraphView.widthAnchor, multiplier: 0.6),
        controller.view.centerXAnchor.constraint(equalTo: situpGraphView.centerXAnchor),
        controller.view.centerYAnchor.constraint(equalTo: situpGraphView.centerYAnchor)
    ])
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
