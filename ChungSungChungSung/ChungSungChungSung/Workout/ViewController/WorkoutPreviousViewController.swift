//
//  WorkoutPreviousViewController.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/12.
//

import UIKit
import FSCalendar

class WorkoutPreviousViewController: UIViewController {

    var events2: [Date] = []
    fileprivate let calendar = FSCalendar()
    fileprivate let tableView = UITableView()
    var 운동들 = ["푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝","푸쉬업", "러닝"]
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        navigationItem.title = "지난 기록"
        navigationController?.navigationBar.topItem?.backButtonTitle = "운동"
        view.backgroundColor = .systemGray6
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
        setUpEvents()
        
        let tempView = UIView()
        tempView.addSubview(workoutRecord)
        workoutRecord.centerY(inView: tempView)
        workoutRecord.anchor(left: tempView.leftAnchor, paddingLeft: 8)
        view.addSubview(tempView)
        tempView.anchor(top: calendar.bottomAnchor, left: calendar.leftAnchor, right: calendar.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingRight: 0, height: 30)
        
        let emptyView = UIView()
        let vstack = UIStackView(arrangedSubviews: [tableView, emptyView])
        vstack.axis = .vertical
        view.addSubview(vstack)
        vstack.spacing = 16
        
        vstack.anchor(top: tempView.bottomAnchor, left: calendar.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: calendar.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.anchor(top: vstack.topAnchor, left: calendar.leftAnchor, right: calendar.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingRight: 0, height: 44 * CGFloat(운동들.count))

    }

    func setUpEvents() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let sampledate5 = formatter.date(from: "2022-08-1")
        let sampledate6 = formatter.date(from: "2022-08-5")
        let sampledate7 = formatter.date(from: "2022-08-6")
        events2 = [sampledate5!, sampledate6!, sampledate7!]
        
    }
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
}

extension WorkoutPreviousViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date1 = formatter.string(from: date)
        let date2 = formatter.string(from: Date())
        
        if date1 == date2 {
            return .white
        } else if events2.contains(date) {
            return .진보라
        } else {
            return .black
        }
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        
        if events2.contains(date) {
            return .연보라
        }
        return nil
    }
        
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date))
        self.dismiss(animated: true, completion: nil)
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
        return 운동들.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutPreviousTableViewCell.cellID, for: indexPath) as? WorkoutPreviousTableViewCell else { return UITableViewCell() }
        cell.workoutNameLabel.text = 운동들[indexPath.row]
        cell.separatorInset = (indexPath.row == 운동들.count - 1) ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width) : UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        
        return cell
    }
    
}
