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
    
    private var selectedMonth: String = "8"
    private var selectedDate: String = "10"
    private var selectedDateText: String?
    private var selectedTodayText: String?
    
    private var workoutList = WorkoutData().list
    private var workout: WorkoutModel?
    
    @IBOutlet weak var selectedDateView: UILabel!
    @IBOutlet weak var dailyCalendarView: UICollectionView!

    @IBOutlet weak var todaysWorkoutView: UITableView!
    @IBOutlet weak var workoutListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigationTitle()
        selectedDateView.text = "\(selectedMonth)월 \(dates[dates.count - 1])일, 오늘"
        
        self.dailyCalendarView.backgroundColor = .clear
        
        todaysWorkoutView.delegate = self
        todaysWorkoutView.dataSource = self
        workoutListView.delegate = self
        workoutListView.dataSource = self
    }
    
    private func configNavigationTitle() {
        let viewWidth = self.view.bounds.width - 140
        let workoutViewTitle = UILabel(frame: CGRect(x: 25, y: 0, width: viewWidth, height: 20))
        workoutViewTitle.textAlignment = .left
        workoutViewTitle.font = UIFont.boldSystemFont(ofSize: 28)
        workoutViewTitle.text = "운동"
        
        self.navigationItem.titleView = workoutViewTitle
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
        
        selectedDateText = "\(selectedMonth)월 \(selectedDate)일"
        selectedTodayText = "\(selectedMonth)월 \(selectedDate)일, 오늘"
        
        print(selectedCell)
        if selectedCell == dates.count - 1 {
            selectedDateView.text = selectedTodayText
        } else {
            selectedDate = dates[selectedCell]
            selectedDateView.text = selectedDateText
        }
    }
}

extension WorkoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        
        let viewWidth = self.view.bounds.width
        let inset = (17 / 390) * viewWidth
        let width = (viewWidth - (inset * 2)) / 6
        let height = (105 / 61) * width
        
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
        var returnCell = UITableViewCell()
        
        if tableView == todaysWorkoutView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "todaysWorkoutCell", for: indexPath) as? TodaysWorkoutCell else { return UITableViewCell() }
            
            let workout = workoutList[indexPath.row]
            cell.todayWorkoutTitle.text = workout.title
            
            returnCell = cell
            
        } else if tableView == workoutListView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "workoutListCell", for: indexPath) as? WorkoutListCell else { return UITableViewCell() }
            let workout = workoutList[indexPath.row]
            cell.workoutTitle.text = workout.title
            
            returnCell = cell
        }
        
        return returnCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workout = workoutList[indexPath.row]
        print("\(indexPath.row) selected.")
        print("\(workout.title)")
    }
}
