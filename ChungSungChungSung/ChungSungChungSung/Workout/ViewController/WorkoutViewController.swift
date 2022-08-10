//
//  WorkoutViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/05.
//

import UIKit

class WorkoutViewController: UIViewController {
    private let calInset: CGFloat = 17.0
    private let numberOfCellsShown = 6
    private var selectedCell: Int = 6
    private var initialSelectedCell: Int = 6
    private var weekdays: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    private var dates: [String] = ["8", "9", "10", "11", "12", "13", "14"]
    
    private var workoutList = WorkoutData().list
    private var workout: WorkoutModel?
    
//    private var workoutData = [
//        ("푸시업", "", "회"),
//        ("달리기", "", "분"),
//        ("풀업", "", "회")
//    ]
//    lazy var list: [WorkoutModel] = {
//        var datalist = [WorkoutModel]()
//        for (title, first, second) in self.workoutData {
//            let workoutdata = WorkoutModel()
//            workoutdata.title = title
//            workoutdata.firstInputType = first
//            workoutdata.secondInputType = second
//
//            datalist.append(workoutdata)
//        }
//        return datalist
//    }()
    
    @IBOutlet weak var selectedDateView: UILabel!
    @IBOutlet weak var dailyCalendarView: UICollectionView!

    @IBOutlet weak var todaysWorkoutView: UITableView!
    @IBOutlet weak var workoutListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigationTitle()
        setSelectedDateView()
        
        self.dailyCalendarView.backgroundColor = .clear
        
//        todaysWorkoutView.register(UITableViewCell.self, forCellReuseIdentifier: "todaysWorkoutCell")
        workoutListView.register(UITableViewCell.self, forCellReuseIdentifier: "todaysWorkoutCell")
        
        todaysWorkoutView.delegate = self
        todaysWorkoutView.dataSource = self
        workoutListView.delegate = self
        workoutListView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setSelectedDateView()
    }
    
    private func configNavigationTitle() {
        let viewWidth = self.view.bounds.width - 140
        let workoutViewTitle = UILabel(frame: CGRect(x: 25, y: 0, width: viewWidth, height: 20))
        workoutViewTitle.textAlignment = .left
        workoutViewTitle.font = UIFont.boldSystemFont(ofSize: 28)
        workoutViewTitle.text = "운동"
        
        self.navigationItem.titleView = workoutViewTitle
    }

    private func setSelectedDateView() {
        var month: String = "8"
        var date: String = "10"
        var selectedDateText: String = "\(month)월 \(date)일"
        var selectedTodayText: String = "\(month)월 \(date)일, 오늘"
        
        print(selectedCell)
        if selectedCell == dates.count - 1 {
            selectedDateView.text = selectedTodayText
        } else {
            date = dates[selectedCell]
            selectedDateView.text = selectedDateText
        }
    }
}

extension WorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyCalendarCell", for: indexPath) as? DailyCalendarCell else {
            return UICollectionViewCell()
        }
        
        cell.dateNumberView.text = dates[indexPath.row]
        cell.dayNameView.text = weekdays[indexPath.row]
        
        cell.dayHighlightView.layer.cornerRadius = ( cell.dayHighlightView.frame.width + 4 ) / 2
        cell.dayHighlightView.backgroundColor = CustomColor.mainPurple
        
        cell.dateHighlightCircleView.layer.cornerRadius = 19
        cell.dateHighlightCircleView.layer.shadowColor = UIColor.systemGray5.cgColor
        cell.dateHighlightCircleView.layer.shadowRadius = 20
        cell.dateHighlightCircleView.layer.shadowOpacity = 1
        cell.dateHighlightCircleView.backgroundColor = CustomColor.dateGreen
        
        if(indexPath.row == initialSelectedCell) {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .right)
        }
        cell.isSelected = indexPath.row == initialSelectedCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.row
    }
}

extension WorkoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        
        let viewWidth = self.view.bounds.width
        let inset = (17 / 390) * viewWidth
//        let spacing = (8 / 390) * viewWidth
        
        let width = (viewWidth - (inset * 2) /*- (spacing * 5)*/) / 6
        let height = (105 / 61) * width
        
//        flow.minimumInteritemSpacing = spacing
//        flow.minimumLineSpacing = spacing
        flow.sectionInset.left = inset
        flow.sectionInset.right = inset
        
        return CGSize(width: width, height: height)
    }
}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todaysWorkoutCell", for: indexPath) as? TodaysWorkoutCell else {
            return UITableViewCell()
        }
        
        let workout = workoutList[indexPath.row]
        cell.workoutTitle.text = workout.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workout = workoutList[indexPath.row]
        print("\(indexPath.row) selected.")
        print("\(workout.title)")
    }
}
