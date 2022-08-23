//
//  WorkoutPreviousViewController.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/12.
//

import UIKit
import FSCalendar
import RealmSwift

class WorkoutPreviousViewController: UIViewController {
    private let defaults = UserDefaults.standard

    var workoutRealm: Results<WorkoutRealm>!
    
    
//    var workoutDates = [String]()
    let dateFormatterHighlight = DateFormatter()
    let 운동안했습니다 = "운동을 하지 않았습니다."
    var events2: [String] = [] {
        willSet {
            calendar.reloadData()
        }
    }
    var ticketTop : NSLayoutConstraint?
     func setup() {
//         ticketTop = tableView.topAnchor.constraintEqualToAnchor(self.topAnchor, constant:100)
         ticketTop = tableView.heightAnchor.constraint(equalToConstant: CGFloat(44*운동들.count))
         ticketTop?.isActive = true
     }
     func update() {
         ticketTop?.constant = CGFloat(44*운동들.count)
     }
    
//    var events2: [Date] = []
    let dateFormatterForWorkout: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyyMMdd"
        return df
    }()
    
    
    fileprivate let calendar = FSCalendar()
    fileprivate let tableView = UITableView()
    var 운동들:[String] = ["푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝"]
    
//    private var workoutList = WorkoutData().list
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func fetchWorkouts(date: Date) {
        if let mealDate = RealmManager.searchWorkoutDataByDateK2(date: dateFormatterForWorkout.string(from: date)) {
//            print("cc",mealDate.count)
            if mealDate.count != 0 {
                운동들 = mealDate.map{$0.name}
//                print(운동들.count)
                tableView.reloadData()
                update()
            } else {
                운동들 = [운동안했습니다]
                tableView.reloadData()
                update()
            }
        } else {
            운동들 = [운동안했습니다]
            tableView.reloadData()
            update()
        }
    }
    
    override func viewDidLoad() {
        navigationItem.title = "지난 기록"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.topItem?.backButtonTitle = "운동"
        navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        view.backgroundColor = CustomColor.bgGray
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        
        events2 = (RealmManager.fetchSearchDidWorkoutDates2() ?? []).map {
            dateFormatterForWorkout.string(from: $0)
        }
        
        fetchWorkouts(date: Date())

        calendar.delegate = self
        calendar.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WorkoutPreviousTableViewCell.self, forCellReuseIdentifier: WorkoutPreviousTableViewCell.cellID)
        
        tableView.layer.cornerRadius = 16
        tableView.rowHeight = 44
        
        view.addSubview(calendar)
        calendar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 300)
        calendar.backgroundColor = .white
        calendar.layer.cornerRadius = 16
        calendar.appearance.todayColor = .진보라
        calendar.headerHeight = 80
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 18)
        calendar.appearance.weekdayTextColor = .systemGray2
        
        let previousButton = UIButton()
        previousButton.addTarget(self, action: #selector(previousTapped(_:)), for: .touchUpInside)
        view.addSubview(previousButton)
        previousButton.anchor(left: calendar.leftAnchor, paddingLeft: 16)
        previousButton.centerY(inView: calendar.calendarHeaderView)
        previousButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        previousButton.tintColor = .black
        
        let nextButton = UIButton()
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .touchUpInside)
        nextButton.tintColor = .black
        view.addSubview(nextButton)
        nextButton.anchor(right: calendar.rightAnchor, paddingRight: 16)
        nextButton.centerY(inView: calendar.calendarHeaderView)
        nextButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        calendar.placeholderType = .none//현재달만
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 13)
        
        let workoutRecord = UILabel()
        workoutRecord.text = "운동 기록"
        workoutRecord.font = UIFont.systemFont(ofSize: Constants.bigText, weight: .bold)
//        setUpEvents()
        
        let tempView = UIView()
        tempView.addSubview(workoutRecord)
        workoutRecord.centerY(inView: tempView)
        workoutRecord.anchor(left: tempView.leftAnchor, paddingLeft: 8)
        view.addSubview(tempView)
        tempView.anchor(top: calendar.bottomAnchor, left: calendar.leftAnchor, right: calendar.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingRight: 0, height: 30)
        
        let emptyView = UIView()
        let vstack = UIStackView(arrangedSubviews: [tableView, emptyView])
        vstack.axis = .vertical
        view.addSubview(vstack)
        vstack.spacing = 16
        
        vstack.anchor(top: tempView.bottomAnchor, left: calendar.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: calendar.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.anchor(top: vstack.topAnchor, left: calendar.leftAnchor, right: calendar.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingRight: 0)
        setup()

        dateFormatterHighlight.dateFormat = "yyyyMMdd"
        dateFormatterHighlight.locale = Locale(identifier: "ko_KR")
        
//        workoutDates = defaults.stringArray(forKey: "workoutDate") ?? [String]()
    }

//    func setUpEvents() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let sampledate5 = formatter.date(from: "2022-08-1")
//        let sampledate6 = formatter.date(from: "2022-08-5")
//        let sampledate7 = formatter.date(from: "2022-08-6")
//        events2 = [sampledate5!, sampledate6!, sampledate7!]
//
//    }
    
//    fileprivate lazy var dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter
//    }()
    
}

extension WorkoutPreviousViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        let date1 = formatter.string(from: date)
        let date2 = formatter.string(from: Date())
        if date1 == date2 {
            return .white
//        } else if events2.contains(date) {
//            return .진보라
        } else {
            return .black
        }
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyyMMdd"
//        formatter.locale = Locale(identifier: "ko_KR")
        
        let selectedDate = dateFormatterForWorkout.string(from: date)
//        print("123",selectedDate)
        let today = dateFormatterForWorkout.string(from: Date())
//        print("1234",today)
//        print("qwer", events2, dateFormatterForWorkout.string(from: date))
        if selectedDate == today {
            return CustomColor.mainPurple
        } else if events2.contains(dateFormatterForWorkout.string(from: date)) {
            return CustomColor.calendarRedColor
        }
//        else if workoutDates.contains(dateFormatterHighlight.string(from: date)) {
////        if events2.contains(date) {
//            return CustomColor.calendarRedColor
////        }
//        }
        return nil
    }
        
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

//        if dateFormatterForWorkout.string(from: date) != dateFormatterForWorkout.string(from: Date()) {
//            tableView.isUserInteractionEnabled = false
//        } else {
//            tableView.isUserInteractionEnabled = true
//        }
        self.dismiss(animated: true, completion: nil)
        
       fetchWorkouts(date: date)
        
    }
    
    @objc func nextTapped(_ sender:UIButton) {
        calendar.setCurrentPage(getNextMonth(date: calendar.currentPage), animated: true)
    }

    @objc func previousTapped(_ sender:UIButton) {
        calendar.setCurrentPage(getPreviousMonth(date: calendar.currentPage), animated: true)
    }

    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }

    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
}

extension WorkoutPreviousViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(운동들.count, "???")
        return 운동들.count
//        return workoutList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutPreviousTableViewCell.cellID, for: indexPath) as? WorkoutPreviousTableViewCell else { return UITableViewCell() }
        cell.workoutNameLabel.text = 운동들[indexPath.row]
//        cell.workoutNameLabel.text = workoutList[indexPath.row].title
//        cell.separatorInset = (indexPath.row == 운동들.count - 1) ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width) : UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "WorkoutTempAdd", bundle: .main).instantiateViewController(withIdentifier: "WorkoutTempAddViewController") as? WorkoutTempAddViewController else { return }
        let workout = 운동들[indexPath.row]
        vc.workoutAddTitleText = workout
        
        guard workout != "운동을 하지 않았습니다." else {
            showToast()
            return
        }
//        vc.workout = workout
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RealmManager {
    static func fetchSearchDidWorkoutDates2() -> [Date]? {
        let localRealm = try! Realm()
        let dates = Array(localRealm.objects(WorkoutRealm.self)
            .map { workoutRealm in
                workoutRealm.date
            })
        if dates.count == 0 {
            return nil
        } else {
            return dates
        }
//            .map { $0.date }
            
    }
    
    static func searchWorkoutDataByDateK2(date: String) -> Results<WorkoutRealm>? {
        let realm = localRealm.objects(WorkoutRealm.self)
        let target = realm.filter("dateSearching == '\(date)'")
        if target.count == 0 {
            return nil
        } else {
            return target
        }
    }
    static func deleteAllWorkoutData2() {
        
        let localRealm = try! Realm()
        let alls = localRealm.objects(WorkoutRealm.self)
        try! localRealm.write {
            localRealm.delete(alls)
        }
    }
    
}

extension String {
    func String2DateTypeForWorkout2() -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.date(from: self)?.addingTimeInterval(60*60*9)
    }
}

extension WorkoutPreviousViewController {
    func showToast() {
        let toastLabel = UILabel()
        view.addSubview(toastLabel)
        toastLabel.anchor(top: view.bottomAnchor, paddingTop: -200, width: 200, height: 60)
        toastLabel.centerX(inView: view)
        toastLabel.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        toastLabel.layer.borderColor = UIColor.systemGray5.cgColor
        toastLabel.layer.borderWidth = 1
        toastLabel.textColor = UIColor.black
        toastLabel.font = UIFont.systemFont(ofSize: 15)
        toastLabel.text = "먼저 운동을 추가해주세요!"
        toastLabel.textAlignment = .center
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 25
        toastLabel.clipsToBounds = true
//        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
