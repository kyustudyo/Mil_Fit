//
//  WorkoutViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/05.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    var events = [String]()
    private let workoutViewTitle = "운동"
    private var workoutList = WorkoutData().list
//    private var workout: WorkoutModel?
//    var todaysWorkout: [WorkoutModel] = []
//    var numberOfTodaysWorkout: Int?
    //TODO 시작일 설정
    let 시작일 = CalendarHelper().addDays(date: Date(), days: -300)
    var selectedDate = Date()
    var totalSquares = [Date]()
    
    var currentIndex: CGFloat = 0
    var isOneStepPaging = true
    
    @IBOutlet weak var selectedDateView: UILabel!
    @IBOutlet weak var dailyCalendarView: UICollectionView!

    @IBOutlet weak var todaysWorkoutView: UITableView!
    @IBOutlet weak var todaysWorkoutEditButton: UIButton!
    @IBOutlet weak var workoutListView: UITableView!
    @IBOutlet weak var workoutListEditButton: UIButton!
    
    @IBAction private func didTapTodaysWorkoutEditButton(_ sender: UIButton) {
        guard let todaysWorkoutEditView = UIStoryboard(name: "TodaysWorkoutEdit", bundle: .main).instantiateViewController(withIdentifier: "TodaysWorkoutEditViewController") as? TodaysWorkoutEditViewController else { return }
        todaysWorkoutEditView.workoutList = workoutList
        present(todaysWorkoutEditView, animated: true, completion: nil)
    }
    
    @IBAction private func didTapWorkoutListEditButton(_ sender: UIButton) {
        guard let workoutListEditView = UIStoryboard(name: "WorkoutListEdit", bundle: .main).instantiateViewController(withIdentifier: "WorkoutListEditViewController") as? WorkoutListEditViewController else { return }
        present(workoutListEditView, animated: true, completion: nil)
    }
    
    func setUpEvents() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let sampledate5 = formatter.string(from: CalendarHelper().addDays(date: Date(), days: -1))
        let sampledate6 = formatter.string(from: CalendarHelper().addDays(date: Date(), days: -3))
        let sampledate7 = formatter.string(from: CalendarHelper().addDays(date: Date(), days: -6))
        events = [sampledate5, sampledate6, sampledate7]
        
    }
    override func viewWillAppear(_ animated: Bool) {
        configNavigationTitle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEvents()
        view.backgroundColor = .systemGray6
//        configNavigationTitle()
//        self.dailyCalendarView.isPagingEnabled = true
//        let backBarButtonItem = UIBarButtonItem(title: workoutViewTitle, style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backBarButtonItem
        
        let editBarButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(goPreviousViewController))
        editBarButton.tintColor = .black
        self.navigationItem.rightBarButtonItems = [editBarButton]
        
        self.dailyCalendarView.backgroundColor = .clear
        todaysWorkoutView.backgroundColor = .clear
        todaysWorkoutView.contentInset.top = -30
        workoutListView.backgroundColor = .clear
        workoutListView.contentInset.top = -30
        
        todaysWorkoutEditButton.tintColor = CustomColor.mainPurple
        workoutListEditButton.tintColor = CustomColor.mainPurple
        
        todaysWorkoutView.delegate = self
        todaysWorkoutView.dataSource = self
        workoutListView.delegate = self
        workoutListView.dataSource = self
        setWeekView()
    }
    
    @objc fileprivate func goPreviousViewController() {
        let vc = WorkoutPreviousViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configNavigationTitle() {
        navigationItem.title = "운동"
//        let backBarButtonItem = UIBarButtonItem(title: workoutViewTitle, style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backBarButtonItem
//        navigationController?.navigationBar.topItem?.backButtonTitle = "메인"
//        let viewWidth = self.view.bounds.width - 140
//        let workoutViewTitleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: viewWidth, height: 20))
//        workoutViewTitleLabel.textAlignment = .left
//        workoutViewTitleLabel.font = UIFont.boldSystemFont(ofSize: 28)
//        workoutViewTitleLabel.text = workoutViewTitle
//        navigationController?.navigationItem.titleView = workoutViewTitleLabel
//        self.navigationItem.titleView = workoutViewTitleLabel
    }
    func setWeekView()
    {
        totalSquares.removeAll()
        
        var current = 시작일
        //TODO: 끝일
        let nextSunday = CalendarHelper().addDays(date: Date(), days: 300)
        while (current < nextSunday)
        {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        if let index = totalSquares.firstIndex(where: { date in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = " yyyy-MM-dd"
            return dateFormatter.string(from: date) == dateFormatter.string(from: Date())
        }) {
            DispatchQueue.main.async {
//                self.dailyCalendarView.isPagingEnabled = true
                self.dailyCalendarView.scrollToItem(at: [0, index], at: .centeredHorizontally, animated: false)
                self.dailyCalendarView.decelerationRate = .fast
                self.dailyCalendarView.isPagingEnabled = false
                self.updateHeaderLabel()
                self.dailyCalendarView.reloadData()
            }
            
        }

    }
    func updateHeaderLabel() {
        selectedDateView.text = "\(CalendarHelper().monthString(date: selectedDate))" + " " +  "\(CalendarHelper().dayOfMonth(date: selectedDate))일"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " yyyy-MM-dd"
        
        if dateFormatter.string(from: Date()) == dateFormatter.string(from: selectedDate) {
            selectedDateView.text? += ", 오늘"
        }
    }
}

extension WorkoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyCalendarCell", for: indexPath) as? DailyCalendarCell else {
            return UICollectionViewCell()
        }
 
        let date = totalSquares[indexPath.item]
        cell.dayNameView.text = CalendarHelper().weekDataAt(indexPath.row % 7)
        cell.dateNumberView.text = String(CalendarHelper().dayOfMonth(date: date))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        if(dateFormatter.string(from: date) == dateFormatter.string(from: selectedDate)) {
            let col1 = UIColor(red: 170/255.0, green: 144/255.0, blue: 239/255.0, alpha: 1)
            let col2 = UIColor(red: 113/255.0, green: 87/255.0, blue: 219/255.0, alpha: 1)
            cell.dayHighlightView.setGradient2(color1: col1, color2: col2, bounds: cell.dayHighlightView.bounds)
            cell.dayHighlightView.isHidden = false
            cell.dayNameView.textColor = .white
        }
        else {
            cell.dayHighlightView.isHidden = true
            cell.dayNameView.textColor = .black
        }
        cell.dateHighlightCircleView.layer.cornerRadius = cell.dateHighlightCircleView.bounds.width / 2 
        cell.dateHighlightCircleView.layer.shadowOpacity = 0.2
//        cell.dateHighlightCircleView.layer.shadowRadius = 4
        cell.dateHighlightCircleView.layer.shadowOffset = CGSize(width: 2, height: 3)
        if events.contains(dateFormatter.string(from: date)) {
            cell.dateHighlightCircleView.backgroundColor = UIColor(hex: "FEB4B4")
        } else {
            cell.dateHighlightCircleView.backgroundColor = UIColor.white
        }
//        cell.backgroundColor = .red
//        dailyCalendarView.backgroundColor = .yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        updateHeaderLabel()
        dailyCalendarView.reloadData()
    }

}

extension WorkoutViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.weekLineSpacing
//        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 6 * Constants.weekLineSpacing) / 7.0

        let height = (collectionView.frame.size.height)
        return  CGSize(width: width, height: height)
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
        returnCell.layer.shadowColor = UIColor.systemGray5.cgColor
        returnCell.layer.shadowRadius = 20
        returnCell.layer.shadowOpacity = 1
        
        return returnCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workout = workoutList[indexPath.row]
        print("\(indexPath.row) \(workout.title) selected.")
  
        if tableView == todaysWorkoutView {
            guard let workoutAddView = UIStoryboard(name: "WorkoutAdd", bundle: .main).instantiateViewController(withIdentifier: "WorkoutAddViewController") as? WorkoutAddViewController else { return }
            workoutAddView.workoutAddTitleText = workout.title
            workoutAddView.workout = workout
            print(navigationController)
            self.navigationController?.pushViewController(workoutAddView, animated: true)
        }
    }
}

//TODO: 다른 파일과 묶기
extension UIView {
    func setGradient2(color1:UIColor,color2:UIColor, width: CGFloat? = nil, bounds: CGRect? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)

        if let width = width {
            gradient.frame = CGRect(x: 0, y: 0, width: width, height: 20)
            gradient.cornerRadius = 10
        }
        if let bounds = bounds {
            gradient.frame = bounds
            gradient.cornerRadius = ( bounds.width ) / 2
        }
        layer.addSublayer(gradient)
    }

}

extension WorkoutViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            guard let layout = self.dailyCalendarView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            
            let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
            let index: Int
            if velocity.x > 0 {
                index = Int(ceil(estimatedIndex))
            } else if velocity.x < 0 {
                index = Int(floor(estimatedIndex))
            } else {
                index = Int(round(estimatedIndex))
            }
            
            targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
        }

}
