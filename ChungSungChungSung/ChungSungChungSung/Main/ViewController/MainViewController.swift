//
//  MainViewController.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/06.
//

import UIKit
import FSCalendar

//TODO: scrollview

//전역일 글자

class MainViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource  {

    var 전역가까움: Float = 0.9
    let eatPercent = 70.0
    let workoutPercent = 45.0
    let basicPercent = 40.0
    
    var events2: [Date] = []
    var calendar = FSCalendar()
    
    fileprivate let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022년 8월 21일"
        label.font = UIFont.systemFont(ofSize: Constants.bigText, weight: .bold)
        return label
    }()
    
//    fileprivate let todayMent: UILabel = {
//        let label = UILabel()
//        label.text = "오늘도 열심히 운동해요!"
//        return label
//    }()
    
    
    fileprivate let endDayBar: UIProgressView = {
        
        let newbar = GradientProgressView(progressViewStyle: UIProgressView.Style.bar)
        let col1 = UIColor(red: 170/255.0, green: 144/255.0, blue: 239/255.0, alpha: 1)
        let col2 = UIColor(red: 113/255.0, green: 87/255.0, blue: 219/255.0, alpha: 1)
        newbar.firstColor = col2
        newbar.secondColor = col1
        newbar.setHeight(height: 38)
        newbar.clipsToBounds = true
        newbar.layer.cornerRadius = 20
        newbar.layer.sublayers![1].cornerRadius = 20
        newbar.subviews[1].clipsToBounds = true
        newbar.trackTintColor = .연보라
        
//        let bar = UIProgressView()
//        bar.setHeight(height: 38)
//        bar.progressTintColor = .진보라
//        bar.trackTintColor = .연보라
//        bar.clipsToBounds = true
//        bar.layer.cornerRadius = 20
        
        
        
//        let gradient = CAGradientLayer()
//        gradient.frame = bar.bounds
//        gradient.colors = [col1, col2]
//        bar.layer.sublayers![1].insertSublayer(gradient, at: 0)
        
        return newbar
    }()
    
    fileprivate let 전역일: UILabel = {
        let label = UILabel()
        label.text = "전역일"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    fileprivate let dDay: UILabel = {
        let label = UILabel()
        label.text = "D-212"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    fileprivate let purposeLabel: UILabel = {
        let label = UILabel()
        label.text = "목표"
        label.font = UIFont.systemFont(ofSize: Constants.bigText, weight: .bold)
        return label
    }()
    
    fileprivate let mealLabel: UILabel = {
        let label = UILabel()
        label.text = "식단"
        label.font = UIFont.systemFont(ofSize: Constants.bigText, weight: .bold)
        return label
    }()
    
    fileprivate let moreButton: UIButton = {
       let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.smallText, weight: .light)
        button.setTitleColor(UIColor.systemGray2, for: .normal)
        button.addTarget(self, action: #selector(goMoreMeal), for: .touchUpInside)
        return button
    }()
    fileprivate let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "더보기"
        label.font = UIFont.systemFont(ofSize: Constants.smallText)
        label.textColor = .systemGray2
        return label
    }()
    
    fileprivate let calLabel: UILabel = {
        let label = UILabel()
        label.text = "칼로리"
        label.font = UIFont.systemFont(ofSize: Constants.bigText, weight: .bold)
        return label
    }()
    
    fileprivate let workoutLabel: UILabel = {
        let label = UILabel()
        label.text = "운동"
        label.font = UIFont.systemFont(ofSize: Constants.bigText, weight: .bold)
        return label
    }()
    
    fileprivate lazy var basicRoundedView: UIView = {
        let roundedView = Bar()
        roundedView.progressValue = basicPercent
        roundedView.progressColor = .연빨강
        roundedView.trackColor = .clear
        return roundedView
    }()
    
    fileprivate func shortRoundedView(color: UIColor) -> UIView {
        let view = UIView()
        view.setWidth(width: 30)
        view.setHeight(height: 14)
        view.layer.cornerRadius = 8
        view.backgroundColor = color
        return view
    }

    fileprivate func shortMent(ment: String, value: Int) -> UIView {
        let mentLabel = UILabel()
        mentLabel.text = ment
        mentLabel.font = .systemFont(ofSize: 13)
        mentLabel.textColor = .black
        let valueLabel = UILabel()
        valueLabel.text = "\(value)kcal"
        valueLabel.font = .systemFont(ofSize: 12)
        valueLabel.textColor = .systemGray2
        let vstack = UIStackView(arrangedSubviews: [mentLabel, valueLabel])
        vstack.axis = .vertical
        vstack.alignment = .leading
        return vstack
    }
    
    @objc fileprivate func goMoreMeal() {
        print("more meal")
        let vc = MainMealViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    fileprivate lazy var workoutRoundedView: UIView = {
        let roundedView = Bar()
        roundedView.progressValue = basicPercent + workoutPercent
        roundedView.progressColor = .연노랑
        roundedView.trackColor = .clear
        return roundedView
    }()
    
    fileprivate lazy var eatRoundedView: UIView = {
        let roundedView = Bar()
        roundedView.progressValue = eatPercent
        roundedView.progressColor = .연보라
        roundedView.trackColor = .clear
        return roundedView
    }()
    
    private let purposeCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
//        view.itemSize = Constants.itemSize
        view.minimumLineSpacing = Constants.lineSpacing
//        view.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        view.scrollDirection = .horizontal
        return view
      }()
    
    private let mealCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
//        view.itemSize = Constants.itemSize
        view.minimumLineSpacing = Constants.lineSpacing
//        view.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        view.scrollDirection = .horizontal
        return view
      }()
    
     private lazy var purposeCollectionView: UICollectionView = {
         let view = UICollectionView(frame: .zero, collectionViewLayout: purposeCollectionViewFlowLayout)
         
         view.register(PurposeCollectionViewCell.self, forCellWithReuseIdentifier: PurposeCollectionViewCell.cellID)
         view.dataSource = self
         view.delegate = self
       return view
     }()
    
    private lazy var mealCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: mealCollectionViewFlowLayout)
        view.register(mealCollectionViewCell.self, forCellWithReuseIdentifier: mealCollectionViewCell.cellID)
        view.dataSource = self
        view.delegate = self
      return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        //다른 뷰컨에서 navi를 보이므로 
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        calendar.delegate = self
        calendar.dataSource = self
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        let emptyView = UIView()
        emptyView.backgroundColor = .white
        scrollView.addSubview(emptyView)
        emptyView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor,bottom: scrollView.bottomAnchor ,right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0,paddingBottom: 0 ,paddingRight: 0)
        emptyView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        emptyView.backgroundColor = .systemGray6
    
        //MARK: (날짜 + 멘트)
        let stack = UIStackView(arrangedSubviews: [dateLabel])
//        stack.axis = .vertical
        emptyView.addSubview(stack)
        stack.anchor(top: emptyView.topAnchor, left: emptyView.leftAnchor, right: emptyView.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)
        //TODO
        

        //MARK: 전역일 프로그레스


        
        emptyView.addSubview(전역일)
        전역일.anchor(top: stack.bottomAnchor, left: stack.leftAnchor, paddingTop: 24.0, paddingLeft: 0)
        emptyView.addSubview(dDay)
        dDay.anchor(top: dateLabel.bottomAnchor, right: emptyView.leftAnchor,paddingTop: 24.0, paddingRight: 전역가까움 > 0.1 ? -CGFloat(전역가까움) * (UIScreen.main.bounds.width - 16) : -60)
        
        emptyView.addSubview(endDayBar)
        endDayBar.anchor(top:전역일.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor,paddingTop: 12, paddingLeft: 0, paddingRight: 0)
        endDayBar.progress = 전역가까움
        
        
        //MARK: (목표들)
        let purposeStack = UIStackView(arrangedSubviews: [purposeLabel, purposeCollectionView])
        purposeStack.axis = .vertical
        purposeStack.spacing = 8
        emptyView.addSubview(purposeStack)
        purposeStack.anchor(top: endDayBar.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
        purposeCollectionView.anchor(left: stack.leftAnchor, right: stack.rightAnchor, paddingLeft: 0, paddingRight: 0)
        purposeCollectionView.setHeight(height: Constants.purposeCellHeight)
        purposeCollectionView.backgroundColor = .systemGray6
        //MARK: 운동 달력

        emptyView.addSubview(workoutLabel)
        workoutLabel.anchor(top: purposeStack.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
        
        emptyView.addSubview(calendar)
        calendar.anchor(top: workoutLabel.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 300)
        calendar.backgroundColor = .white
        calendar.layer.cornerRadius = 16
        
        calendar.appearance.todayColor = .진보라
        calendar.allowsSelection = false
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
        setUpEvents()
        
        //MARK: 식단
        let mealHStack = UIStackView(arrangedSubviews: [mealLabel, moreButton])
        mealHStack.alignment = .firstBaseline
        moreButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let mealStack = UIStackView(arrangedSubviews: [mealHStack, mealCollectionView])
        mealCollectionView.backgroundColor = .systemGray6
        mealStack.axis = .vertical
        mealStack.spacing = 8
        emptyView.addSubview(mealStack)
        mealStack.anchor(top: calendar.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
        mealCollectionView.anchor(left: stack.leftAnchor, right: stack.rightAnchor, paddingLeft: 0, paddingRight: 0)
        mealCollectionView.setHeight(height: Constants.mealCellHeight)
        
        //MARK: 칼로리
        
        emptyView.addSubview(calLabel)
        calLabel.anchor(top: mealStack.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
        let calContainerView = UIView()
        calContainerView.layer.cornerRadius = 16
        emptyView.addSubview(calContainerView)
        calContainerView.backgroundColor = .white
        calContainerView.anchor(top: calLabel.bottomAnchor, left: stack.leftAnchor, bottom: emptyView.bottomAnchor,right: stack.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 60,paddingRight: 0, height: 160)
        
        calContainerView.addSubview(eatRoundedView)
        eatRoundedView.anchor(top: calContainerView.topAnchor, left: calContainerView.leftAnchor, right: calContainerView.rightAnchor, paddingTop: 26, paddingLeft: 22, paddingRight: 0, height: 14)
        
        calContainerView.addSubview(workoutRoundedView)
        workoutRoundedView.anchor(top: eatRoundedView.bottomAnchor, left: eatRoundedView.leftAnchor, right: eatRoundedView.rightAnchor, paddingTop: 13, paddingLeft: 0, paddingRight: 0, height: 14)
        
        calContainerView.addSubview(basicRoundedView)
        basicRoundedView.anchor(top: eatRoundedView.bottomAnchor, left: eatRoundedView.leftAnchor, right: eatRoundedView.rightAnchor, paddingTop: 13, paddingLeft: 0, paddingRight: 0, height: 14)
        
        //TODO: 중복
        let eatCal = shortRoundedView(color: .연보라)
        let eatMentVstack = shortMent(ment: "먹은 대사량", value: 1700)
        let 먹은칼로리 = UIStackView(arrangedSubviews: [eatCal, eatMentVstack])
        먹은칼로리.axis = .vertical
        먹은칼로리.spacing = 6
        먹은칼로리.alignment = .leading
        
        let basicCal = shortRoundedView(color: .연빨강)
        let basicMentVstack = shortMent(ment: "기초 대사량", value: 1700)
        let 기초칼로리 = UIStackView(arrangedSubviews: [basicCal, basicMentVstack])
        기초칼로리.axis = .vertical
        기초칼로리.spacing = 6
        기초칼로리.alignment = .leading
        
        let workOutCal = shortRoundedView(color: .연노랑)
        let workoutMentVstack = shortMent(ment: "운동 칼로리", value: 1700)
        let 운동칼로리 = UIStackView(arrangedSubviews: [workOutCal, workoutMentVstack])
        운동칼로리.axis = .vertical
        운동칼로리.spacing = 6
        운동칼로리.alignment = .leading
        
        let 세개칼로리스택 = UIStackView(arrangedSubviews: [먹은칼로리, 기초칼로리, 운동칼로리])
        calContainerView.addSubview(세개칼로리스택)
        세개칼로리스택.distribution = .equalCentering
        세개칼로리스택.anchor(top: basicRoundedView.bottomAnchor, left: calContainerView.leftAnchor, right: calContainerView.rightAnchor, paddingTop: 24, paddingLeft: 22, paddingRight: 16)

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

//MARK: 목표 collectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case purposeCollectionView:
            print("count purposeCollectionView")
            return 2
        case mealCollectionView:
            print("count mealCollectionView")
            return 3
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case purposeCollectionView:
            print("cell purposeCollectionView")
            guard let cell = purposeCollectionView.dequeueReusableCell(withReuseIdentifier: PurposeCollectionViewCell.cellID, for: indexPath) as? PurposeCollectionViewCell else { return UICollectionViewCell() }
            cell.delegate = self
            cell.backgroundColor = .white
            return cell
        case mealCollectionView:
            print("cell mealCollectionView")
            guard let cell = mealCollectionView.dequeueReusableCell(withReuseIdentifier: mealCollectionViewCell.cellID, for: indexPath) as? mealCollectionViewCell else { return UICollectionViewCell() }
            cell.backgroundColor = .white
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

//extension MainViewController {
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        UIView.animate(withDuration: 0.5) { [weak self] in
//            guard velocity.y != 0 else { return }
//            if velocity.y < 0 {
//                let height = self?.tabBarController?.tabBar.frame.height ?? 0.0
//                self?.tabBarController?.tabBar.alpha = 1.0
//                self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - height)
//            } else {
//                self?.tabBarController?.tabBar.alpha = 0.0
//                self?.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
//            }
//        }
//    }
//}
extension MainViewController: UICollectionViewDelegateFlowLayout {
    // 셀 사이즈 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        print(collectionView)
        switch collectionView {
        case purposeCollectionView:
//            let width: CGFloat = (view.bounds.width - (20 * 5))
            let width: CGFloat = Constants.purposeCellWidth
    //        let height: CGFloat = width + 35
            let height: CGFloat = Constants.purposeCellHeight
            return CGSize(width: width, height: height)
            
        case mealCollectionView:
            let width: CGFloat = Constants.mealCellWidth
    //        let height: CGFloat = width + 35
            let height: CGFloat = Constants.mealCellHeight
            return CGSize(width: width, height: height)
            
        default:
            return CGSize()
        }

        
    }
    
}

//MARK: 식단 collectionView



extension MainViewController {
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//
//        if self.events2.contains(date){
//            return 2
//        }
//        return 0
//    }
//
          // Default Event Dot 색상 분기처리 - FSCalendarDelegateAppearance
//      func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]?{
//          if self.events.contains(date){
//              return [UIColor.red]
//          }
//
//          if self.events2.contains(date){
//              return [UIColor.black]
//          }
//
//          return nil
//      }
//
//    // 이벤트 누르면 변함
//      func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
//          if self.events.contains(date){
//              return [UIColor.brown]
//          }
//
//          if self.events2.contains(date){
//              return [UIColor.yellow]
//          }
//          return nil
//      }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
            let eventScaleFactor: CGFloat = 1.8
            cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
    }
        
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: 3)
    }
    
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
//    func maximumDate(for calendar: FSCalendar) -> Date {
//        return Date()
//    }
//
//    func minimumDate(for calendar: FSCalendar) -> Date {
//        return Date()
//    }
    
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
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        
        if events2.contains(date) {
            return .연보라
        }
//        if let color = self.fillDefaultColors[key] {
//            return UIColor.systemPink
//        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date))
        self.dismiss(animated: true, completion: nil)
    }

}

extension MainViewController: FSCalendarDelegateAppearance {
    
}

enum Constants {
    static let lineSpacing = 16.0
    static let weekLineSpacing = 6.0
    static let purposeCellHeight = 107.0
    static let mealCellHeight = 210.0//191
    static let purposeCellWidth = 289.0
    static let mealCellWidth = 160.0 //145.0
    static let bigText = 22.0
    static let smallText = 15.0
    static let middleText = 17.0
  }

extension MainViewController: didPurpose {
    func getThumbUp() {
        print("get thumb up in vc")
    }
}

//ref: https://medium.com/academy-poa/how-to-create-a-uiprogressview-with-gradient-progress-in-swift-2d1fa7d26f24
class GradientProgressView: UIProgressView {
    
    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let gradientImage = UIImage(bounds: self.bounds, colors: [firstColor, secondColor]) {
            self.progressImage = gradientImage
        }
    }
}
