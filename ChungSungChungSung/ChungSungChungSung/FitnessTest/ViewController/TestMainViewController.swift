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
    
    @IBOutlet weak var situpGoalLabel: UILabel!
    @IBOutlet weak var pushupGoalLabel: UILabel!
    @IBOutlet weak var runningGoalLabel: UILabel!
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
    
    var runningData: GraphData!
    var pushupData: GraphData!
    var situpData: GraphData!
    let localRealm = try! Realm()
    var fitnessTestRealm: Results<FitnessTestRealm>!
    let emptyView = UIView()
    let emptyLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "체력검정"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode =  .always
        fitnessTestRealm = localRealm.objects(FitnessTestRealm.self).sorted(byKeyPath: "dateSorting", ascending: false)
        fitnessMainTableView.reloadData()
        if fitnessTestRealm.filter("isPractice == false").count == 0 {
            drawEmptyView()
        }else {
            emptyView.isHidden = true
            emptyLabel.isHidden = true
            fitnessGraphButton.isHidden = false
            drawGraphViewRectangleUI()
            setRunningGraphView()
            setPushupGraphView()
            setSitupGraphView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fitnessTestRealm = localRealm.objects(FitnessTestRealm.self).sorted(byKeyPath: "dateSorting", ascending: false)
        fitnessMainTableView.dataSource = self
        fitnessMainTableView.delegate = self
        fitnessMainTableView.alwaysBounceVertical = false
        let standardButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(didTapStandardButton))
        standardButton.tintColor = CustomColor.mainPurple
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapAddButton))
        addButton.tintColor = CustomColor.mainPurple
        navigationItem.rightBarButtonItems = [standardButton, addButton]
        self.navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        view.backgroundColor = CustomColor.bgGray
        fitnessGraphButton.tintColor = UIColor.clear
        fitnessGraphButton.titleLabel?.text = ""
        drawTableViewUI()
        configureRunningGraphView()
        configurePushupGraphView()
        configureSitupGraphView()
        print("Realm저장위치=\n\(Realm.Configuration.defaultConfiguration.fileURL!)\n")
        
        
    }
    //TODO: 어딨지
    @objc fileprivate func didTapStandardButton(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "FitnessTestStandard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "FitnessTestStandardViewController") as? FitnessTestStandardViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
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
        emptyView.isHidden = false
        emptyLabel.isHidden = false
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
        emptyView.backgroundColor = UIColor.systemGray6
        emptyView.layer.cornerRadius = 20
        fitnessGraphButton.isHidden = true
        emptyLabel.centerX(inView: emptyView)
        emptyLabel.centerY(inView: emptyView)
        emptyLabel.text = "체력검정 기록을 추가해주세요."
        emptyLabel.textColor = UIColor.systemGray2

        
    }
    func drawGraphViewRectangleUI() {
        let date = fitnessTestRealm.filter("isPractice == false").first!.date
        //test
        let runningRealm = fitnessTestRealm.filter("testType == 'running'").filter("isPractice == false").first!
        let pushupRealm = fitnessTestRealm.filter("testType == 'pushup'").filter("isPractice == false").first!
        let situpRealm = fitnessTestRealm.filter("testType == 'situp'").filter("isPractice == false").first!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let convertString = dateFormatter.string(from: date)
        fitnessGraphButton.isHidden = false
        graphRoundedRectangleView.layer.cornerRadius = 20
        graphRoundedRectangleView.backgroundColor = UIColor.systemGray6
        historyFitnessTestLabel.text = "지난 체력검정 결과"
        historyFitnessTestLabel.textColor = UIColor.systemGray
        lastFitnessTestDateLabel.text = convertString
        lastFitnessTestDateLabel.textColor = UIColor.systemGray
        goToHistoryImageView.image = UIImage(systemName: "chevron.right")
        goToHistoryImageView.tintColor = UIColor.systemGray
        runningGraphView.backgroundColor = UIColor.clear
        runningGraphTitleLabel.text = "3Km 달리기"
        runningGraphTitleLabel.textColor = UIColor.systemGray
        runningGraphRecordLabel.text = "\(runningRealm.minutes!)분\(runningRealm.seconds!)초"
        runningGraphRecordLabel.textColor = UIColor.systemGray
        let runningGoalLevel = getGoalLevel(level: runningRealm.level)
        let runningMaxStandard = getMaxStandard(testType: .running, level: runningGoalLevel ?? "특급")
        if runningGoalLevel == nil {
            runningGoalLabel.isHidden = true
        }else {
            runningGoalLabel.isHidden = false
            let remainTime = runningRealm.totalTime! - runningMaxStandard
            runningGoalLabel.text = "\(runningGoalLevel!)까지 \(remainTime / 60)분\(remainTime % 60)초!"
            runningGoalLabel.setTargetStringColor(targetString: "\(remainTime / 60)분\(remainTime % 60)초", color: CustomColor.red!)
        }
        
//        runningGraphRecordLabel.setTargetStringColor(targetString: "\(runningRealm.minutes!):\(runningRealm.seconds!)", color: CustomColor.red!)
        pushupGraphView.backgroundColor = UIColor.clear
        pushupGraphTitleLabel.text = "팔굽혀펴기"
        pushupGraphTitleLabel.textColor = UIColor.systemGray
        pushupGraphRecordLabel.text = "\(pushupRealm.count!)개"
        pushupGraphRecordLabel.textColor = UIColor.systemGray
        let pushupGoalLevel = getGoalLevel(level: pushupRealm.level)
        let pushupMinStandard = getMinStandard(testType: .pushup, level: pushupGoalLevel ?? "특급")
        if pushupGoalLevel == nil {
            pushupGoalLabel.isHidden = true
        }else {
            pushupGoalLabel.isHidden = false
            pushupGoalLabel.text = "\(pushupGoalLevel!)까지 \(pushupMinStandard - pushupRealm.count!)회!"
            pushupGoalLabel.setTargetStringColor(targetString: "\(pushupMinStandard - pushupRealm.count!)회", color: CustomColor.strongPurple!)
        }
        //        pushupGraphRecordLabel.setTargetStringColor(targetString: "\(pushupRealm.count!)개", color: CustomColor.strongPurple!)
        situpGraphView.backgroundColor = UIColor.clear
        situpGraphTitleLabel.text = "윗몸 일으키기"
        situpGraphTitleLabel.textColor = UIColor.systemGray
        situpGraphRecordLabel.text = "\(situpRealm.count!)회"
        situpGraphRecordLabel.textColor = UIColor.systemGray
        let situpGoalLevel = getGoalLevel(level: situpRealm.level)
        let situpMinStandard = getMinStandard(testType: .pushup, level: situpGoalLevel ?? "특급")
        if situpGoalLevel == nil {
            situpGoalLabel.isHidden = true
        }else {
            situpGoalLabel.isHidden = false
            situpGoalLabel.text = "\(situpGoalLevel!)까지 \(situpMinStandard - situpRealm.count!)회!"
            situpGoalLabel.setTargetStringColor(targetString: "\(situpMinStandard - situpRealm.count!)회", color: CustomColor.blue!)
        }
        
        
//        situpGraphRecordLabel.setTargetStringColor(targetString: "\(situpRealm.count!)회", color: CustomColor.blue!)
        }
    func drawTableViewUI() {
        recordTableViewTitleLabel.text = "종목별 최고 기록"
    }
    func setRunningGraphView() {
        let runningRealm = fitnessTestRealm.filter("testType == 'running'").filter("isPractice == false").first
        let runningGoalLevel = getGoalLevel(level: runningRealm?.level ?? "특급")
        let maxStandard = getMaxStandard(testType: .running, level: (runningGoalLevel ?? "특급"))
        var rate: Double = 0
        if runningRealm?.level == "특급" {
            rate = 1
        }else {
            rate = Double(maxStandard) / Double(runningRealm?.totalTime ?? 0)
        }
        runningData.rate = rate
        runningData.level = runningRealm?.level ?? "특급"
    }
    func setPushupGraphView() {
        let pushupRealm = fitnessTestRealm.filter("testType == 'pushup'").filter("isPractice == false").first
        let pushupGoalLevel = getGoalLevel(level: pushupRealm?.level ?? "특급")
        let pushupMinStandard = getMinStandard(testType: .pushup, level: pushupGoalLevel ?? "특급")
        var rate: Double = 0
        if pushupRealm?.level == "특급" {
            rate = 1
        }else {
            rate = Double(pushupRealm?.count ?? 0) / Double(pushupMinStandard)
        }
        pushupData.rate = rate
        pushupData.level = pushupRealm?.level ?? "불합격"
//        UIHostingController(rootView: PushupGraphSwiftUIView(graphData: pushupData))
    }
    func setSitupGraphView() {
        let situpRealm = fitnessTestRealm.filter("testType == 'situp'").filter("isPractice == false").first
        let situpGoalLevel = getGoalLevel(level: situpRealm?.level ?? "특급")
        let situpMinStandard = getMinStandard(testType: .situp, level: situpGoalLevel ?? "특급")
        var rate: Double = 0
        if situpRealm?.level == "특급" {
            rate = 1
        }else {
            rate = Double(situpRealm?.count ?? 0) / Double(situpMinStandard)
        }
        situpData.rate = rate
        situpData.level = situpRealm?.level ?? "불합격"
//        UIHostingController(rootView: SitupGraphSwiftUIView(graphData: situpData))
    }
    func configureRunningGraphView() {
        let runningRealm = fitnessTestRealm.filter("testType == 'running'").filter("isPractice == false").first
        let runningGoalLevel = getGoalLevel(level: runningRealm?.level ?? "특급")
        let maxStandard = getMaxStandard(testType: .running, level: (runningGoalLevel ?? "특급"))
        var rate: Double = 0
        if runningRealm?.level == "특급" {
            rate = 1
        }else {
            rate = Double(maxStandard) / Double(runningRealm?.totalTime ?? 0)
        }
        runningData = GraphData(level: runningRealm?.level ?? "불합격", rate: rate)
        let controller = UIHostingController(rootView: RunningGraphSwiftUIView(graphData: runningData))
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
        let pushupRealm = fitnessTestRealm.filter("testType == 'pushup'").filter("isPractice == false").first
        let pushupGoalLevel = getGoalLevel(level: pushupRealm?.level ?? "특급")
        let pushupMinStandard = getMinStandard(testType: .pushup, level: pushupGoalLevel ?? "특급")
        var rate: Double = 0
        if pushupRealm?.level == "특급" {
            rate = 1
        }else {
            rate = Double(pushupRealm?.count ?? 0) / Double(pushupMinStandard)
        }
        pushupData = GraphData(level: pushupRealm?.level ?? "불합격", rate: rate)
        let controller = UIHostingController(rootView: PushupGraphSwiftUIView(graphData: pushupData))
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
        let situpRealm = fitnessTestRealm.filter("testType == 'situp'").filter("isPractice == false").first
        let situpGoalLevel = getGoalLevel(level: situpRealm?.level ?? "특급")
        let situpMinStandard = getMinStandard(testType: .situp, level: situpGoalLevel ?? "특급")
        var rate: Double = 0
        if situpRealm?.level == "특급" {
            rate = 1
        }else {
            rate = Double(situpRealm?.count ?? 0) / Double(situpMinStandard)
        }
        situpData = GraphData(level: situpRealm?.level ?? "불합격", rate: rate)
        let controller = UIHostingController(rootView: SitupGraphSwiftUIView(graphData: situpData))
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
    
    func getGoalLevel(level: String) -> String? {
        if level == "특급" {
            return nil
        }else if level == "1급" {
            return "특급"
        }else if level == "2급" {
            return "1급"
        }else if level == "3급" {
            return "2급"
        }else {
            return "3급"
        }
    }
}

extension TestMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = fitnessMainTableView.dequeueReusableCell(withIdentifier: TestMainTableViewCell.identifier, for: indexPath) as? TestMainTableViewCell else { return UITableViewCell() }

        let runningRealm: Results<FitnessTestRealm>? = fitnessTestRealm.filter("testType == 'running'")
//        print("러닝\(runningRealm?.sorted(byKeyPath: "totalTime", ascending: false))")
        let runningBest = runningRealm?.sorted(byKeyPath: "totalTime", ascending: true).first ?? nil
        let pushupRealm: Results<FitnessTestRealm>? = fitnessTestRealm.filter("testType == 'pushup'")
//        print("푸시\(pushupRealm?.sorted(byKeyPath: "count", ascending: false))")
        let pushupBest = pushupRealm?.sorted(byKeyPath: "count", ascending: false).first ?? nil
        let situpRealm: Results<FitnessTestRealm>? = fitnessTestRealm.filter("testType == 'situp'")
//        print("싯업\(situpRealm?.sorted(byKeyPath: "count", ascending: false))")
        let situpBest = situpRealm?.sorted(byKeyPath: "count", ascending: false).first ?? nil
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        if indexPath.row == 0 {
            cell.fitnessTitleLabel.text = "3km 달리기"
            cell.fitnessTitleLabel.textColor = CustomColor.red
            if runningRealm?.count == 0 {
//                cell.fitnessRecordDateLabel.isHidden = true
                cell.fitnessRecordLabel.text = "기록을 추가해주세요."
            }else {
                cell.fitnessRecordDateLabel.text = "\(dateFormatter.string(from: runningBest?.date ?? Date()))"
                cell.fitnessRecordLabel.text = "\(runningBest?.minutes ?? 0)분 \(runningBest?.seconds ?? 0)초(\(runningBest?.level ?? "영급"))"
            }
            cell.fitnessImage.image = UIImage(named: "running")
            cell.fitnessImageView.backgroundColor = CustomColor.red
        }else if indexPath.row == 1 {
            cell.fitnessTitleLabel.text = "팔굽혀펴기"
            cell.fitnessTitleLabel.textColor = CustomColor.strongPurple
            if pushupRealm?.count == 0 {
//                cell.fitnessRecordDateLabel.isHidden = true
                cell.fitnessRecordLabel.text = "기록을 추가해주세요."
            }else {
                cell.fitnessRecordDateLabel.text = "\(dateFormatter.string(from: pushupBest?.date ?? Date()))"
                cell.fitnessRecordLabel.text = "\(pushupBest?.count ?? 0)회(\(pushupBest?.level ?? "영급"))"
            }
            cell.fitnessImage.image = UIImage(named: "pushup")
            cell.fitnessImageView.backgroundColor = CustomColor.strongPurple
        }else {
            cell.fitnessTitleLabel.text = "윗몸일으키기"
            cell.fitnessTitleLabel.textColor = CustomColor.blue
            if situpRealm?.count == 0 {
//                cell.fitnessRecordDateLabel.isHidden = true
                cell.fitnessRecordLabel.text = "기록을 추가해주세요."
            }else {
                cell.fitnessRecordDateLabel.text = "\(dateFormatter.string(from: situpBest?.date ?? Date()))"
                cell.fitnessRecordLabel.text = "\(situpBest?.count ?? 0)회(\(situpBest?.level ?? "영급"))"
            }
            cell.fitnessImage.image = UIImage(named: "situp")
            cell.fitnessImageView.backgroundColor = CustomColor.blue
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "TestStoryboard", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "FitnessHistoryViewController") as? FitnessHistoryViewController else {return}
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
