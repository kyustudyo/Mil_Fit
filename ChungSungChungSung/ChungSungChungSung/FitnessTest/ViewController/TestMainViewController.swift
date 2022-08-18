//
//  TestMainViewController.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/06.
//

import UIKit
import SwiftUI
import Charts
import RealmSwift

class GraphData: ObservableObject {
    @Published var level: String
    @Published var rate: Double
    
    init(level: String, rate: Double) {
        self.level = level
        self.rate = rate
    }
}

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
    
//    var runningData: GraphData
//    var pushupData: GraphData
//    var situpData: GraphData
    let localRealm = try! Realm()
    var fitnessTestRealm: Results<FitnessTestRealm>!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "체력검정"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode =  .always
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fitnessTestRealm = localRealm.objects(FitnessTestRealm.self).sorted(byKeyPath: "dateSorting")
//        runningData = GraphData(level: fitnessTestRealm.first?.level ?? "없음 ", rate: calculateGraphRate()
        fitnessMainTableView.dataSource = self
        fitnessMainTableView.delegate = self
        
        let standardButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(didTapStandardButton))
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItems = [standardButton, addButton]
        
        fitnessGraphButton.tintColor = UIColor.clear
        fitnessGraphButton.titleLabel?.text = ""
        
        drawTableViewUI()
        if fitnessTestRealm.filter("isPractice == false").count == 0 {
            drawEmptyView()
        }else {
            drawGraphViewRectangleUI()
            configureRunningGraphView()
            configurePushupGraphView()
            configureSitupGraphView()
        }
    }
    //TODO: 어딨지
    @objc fileprivate func didTapStandardButton() {
        let sb = UIStoryboard(name: "TestStoryboard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "HistoryTestViewController") as? HistoryTestViewController else {return}
    }
    @objc fileprivate func didTapAddButton(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "FitnessTestAddStoryboard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "FitnessTestAdd") as? FitnessTestAddViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func tapHistoryTestButton(_ sender: UIButton) {
        let sb = UIStoryboard(name: "TestStoryboard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "HistoryTestViewController") as? HistoryTestViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
    }
    func drawEmptyView() {
        let emptyView = UIView()
        let emptyLabel = UILabel()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        graphRoundedRectangleView.addSubview(emptyView)
        emptyView.addSubview(emptyLabel)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.widthAnchor.constraint(equalTo: graphRoundedRectangleView.widthAnchor, multiplier: 1),
            emptyView.heightAnchor.constraint(equalTo: graphRoundedRectangleView.heightAnchor, multiplier: 1),
            emptyView.centerXAnchor.constraint(equalTo: graphRoundedRectangleView.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: graphRoundedRectangleView.centerYAnchor)
        ])
        emptyView.backgroundColor = CustomColor.bgGray
        emptyView.layer.cornerRadius = 20
        fitnessGraphButton.isHidden = true
        emptyLabel.centerX(inView: emptyView)
        emptyLabel.centerY(inView: emptyView)
        emptyLabel.text = "체력검정 기록을 추가해주세요."
        emptyLabel.textColor = CustomColor.editGray

        
    }
    func drawGraphViewRectangleUI() {
        fitnessGraphButton.isHidden = false
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
        let data = GraphData(level: "특급", rate: 1)
        let controller = UIHostingController(rootView: RunningGraphSwiftUIView(graphData: data))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.backgroundColor = .clear
        addChild(controller)
        runningGraphView.addSubview(controller.view)
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalTo: runningGraphView.widthAnchor, multiplier: 0.7),
            controller.view.heightAnchor.constraint(equalTo: runningGraphView.heightAnchor, multiplier: 0.7),
            controller.view.centerXAnchor.constraint(equalTo: runningGraphView.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: runningGraphView.centerYAnchor)
        ])
    }
    
    func configurePushupGraphView() {
        let data = GraphData(level: "특급", rate: 1)
    let controller = UIHostingController(rootView: PushupGraphSwiftUIView(graphData: data))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    controller.view.backgroundColor = .clear
    addChild(controller)
    pushupGraphView.addSubview(controller.view)
    NSLayoutConstraint.activate([
        controller.view.widthAnchor.constraint(equalTo: pushupGraphView.widthAnchor, multiplier: 0.7),
        controller.view.heightAnchor.constraint(equalTo: pushupGraphView.heightAnchor, multiplier: 0.7),
        controller.view.centerXAnchor.constraint(equalTo:pushupGraphView.centerXAnchor),
        controller.view.centerYAnchor.constraint(equalTo: pushupGraphView.centerYAnchor)
    ])
    }
    
    func configureSitupGraphView() {
        let data = GraphData(level: "특급", rate: 1)
    let controller = UIHostingController(rootView: SitupGraphSwiftUIView(graphData: data))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    controller.view.backgroundColor = .clear
    addChild(controller)
    situpGraphView.addSubview(controller.view)
    NSLayoutConstraint.activate([
        controller.view.widthAnchor.constraint(equalTo: situpGraphView.widthAnchor, multiplier: 0.7),
        controller.view.heightAnchor.constraint(equalTo: situpGraphView.heightAnchor, multiplier: 0.7),
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
