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

    var 전역가까움: Double = 0.8
    let eatPercent = 70.0
    let workoutPercent = 45.0
    let basicPercent = 40.0
    
    let isMealCollectionView: Bool = false// 부대선택했는지
    let isMealData: Bool = false// 있는 부대인지
    
    var events2: [Date] = []
    var calendar = FSCalendar()
    
    fileprivate let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022년 8월 21일"
        label.font = UIFont.systemFont(ofSize: Constants.bigText + 8, weight: .regular)
        return label
    }()

    fileprivate let endDayBar: UIView = {
       let view = UIView()
        return view
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
    
    fileprivate let moreButtonForCalorie: UIButton = {
       let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.smallText, weight: .light)
        button.setTitleColor(UIColor.systemGray2, for: .normal)
        button.addTarget(self, action: #selector(goMoreCalorie), for: .touchUpInside)
        return button
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
        roundedView.progressColor = CustomColor.strongPurple ?? UIColor.purple
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
    
    @objc fileprivate func goMoreCalorie() {
        print("more meal")
        let vc = MainCalorieViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate lazy var workoutRoundedView: UIView = {
        let roundedView = Bar()
        roundedView.progressValue = basicPercent + workoutPercent
        roundedView.progressColor = CustomColor.red ?? UIColor.red
        roundedView.trackColor = .clear
        return roundedView
    }()
    
    fileprivate lazy var eatRoundedView: UIView = {
        let roundedView = Bar()
        roundedView.progressValue = eatPercent
        roundedView.progressColor = CustomColor.subtlePurple ?? UIColor.purple
        roundedView.trackColor = .clear
        return roundedView
    }()
    
    private let purposeCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.minimumLineSpacing = Constants.lineSpacing
        view.scrollDirection = .horizontal
        return view
      }()
    
    private let mealCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.minimumLineSpacing = Constants.lineSpacing
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
        emptyView.addSubview(stack)
        stack.anchor(top: emptyView.topAnchor, left: emptyView.leftAnchor, right: emptyView.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)

        //MARK: 전역일 프로그레스
        let 전역일들ContainerView = UIView()
        emptyView.addSubview(전역일들ContainerView)
        전역일들ContainerView.layer.cornerRadius = 16
        전역일들ContainerView.backgroundColor = .white
        전역일들ContainerView.setHeight(height: 100)
        전역일들ContainerView.anchor(top: stack.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 16.0, paddingLeft: 0, paddingRight: 0)
        
        let 전역일들 = UIStackView(arrangedSubviews: [전역일, dDay])
        전역일들ContainerView.addSubview(전역일들)
        전역일들.anchor(top: 전역일들ContainerView.topAnchor, left: 전역일들ContainerView.leftAnchor, paddingTop: 26.0, paddingLeft: 16.0)
        전역일들ContainerView.addSubview(endDayBar)
        endDayBar.anchor(top:전역일들.bottomAnchor, left: 전역일들ContainerView.leftAnchor, right: 전역일들ContainerView.rightAnchor,paddingTop: 12, paddingLeft: 16, paddingRight: 16)
        let col1 = UIColor(red: 170/255.0, green: 144/255.0, blue: 239/255.0, alpha: 1)
        let col2 = UIColor(red: 113/255.0, green: 87/255.0, blue: 219/255.0, alpha: 1)
        endDayBar.setGradient(color1: col2, color2: col1, width: (UIScreen.main.bounds.width - Constants.sideSpacing*4) * 전역가까움)
        dDay.anchor(right:전역일들ContainerView.leftAnchor, paddingRight: 전역가까움 > 0.1 ? -(UIScreen.main.bounds.width - Constants.sideSpacing*3) * 전역가까움 : -(전역일.intrinsicContentSize.width + 60))
        
        //MARK: (목표들)
        let purposeStack = UIStackView(arrangedSubviews: [purposeLabel, purposeCollectionView])
        purposeStack.axis = .vertical
        purposeStack.spacing = 8
        emptyView.addSubview(purposeStack)
        purposeStack.anchor(top: 전역일들ContainerView.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
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
        let moreButtons = isMealData ? moreButton : UIView()
        let mealHStack = UIStackView(arrangedSubviews: [mealLabel, moreButtons])
        mealHStack.alignment = .firstBaseline
        moreButtons.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let selectArmyView = UIView()
        let selectArmyLabel = UILabel()
        selectArmyView.backgroundColor = .white
        selectArmyView.layer.cornerRadius = 16
        selectArmyLabel.text = isMealData ? "부대를\n선택하세요" : "해당 부대는 식단 정보를\n제공하지 않습니다"
        selectArmyLabel.textColor = .systemBlue
        selectArmyLabel.numberOfLines = 0
        selectArmyLabel.textAlignment = .center
        selectArmyView.addSubview(selectArmyLabel)
        selectArmyLabel.centerX(inView: selectArmyView)
        selectArmyLabel.centerY(inView: selectArmyView)
        
        let mealOrNothing = isMealCollectionView ? mealCollectionView : selectArmyView
        let mealStack = UIStackView(arrangedSubviews: [mealHStack, mealOrNothing])
        mealCollectionView.backgroundColor = .systemGray6
        mealStack.axis = .vertical
        mealStack.spacing = 8
        emptyView.addSubview(mealStack)
        mealStack.anchor(top: calendar.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
        
        mealOrNothing.anchor(left: stack.leftAnchor, right: stack.rightAnchor, paddingLeft: 0, paddingRight: 0)
        mealOrNothing.setHeight(height: Constants.mealCellHeight)
        
        if !isMealCollectionView {
            let selectArmyButton = UIButton()
            emptyView.addSubview(selectArmyButton)
            selectArmyButton.addTarget(self, action: #selector(goSelectArmyViewController), for: .touchUpInside)
            selectArmyButton.backgroundColor = .clear
            selectArmyButton.anchor(top: mealOrNothing.topAnchor, left: mealOrNothing.leftAnchor, bottom: mealOrNothing.bottomAnchor, right: mealOrNothing.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        }
        //MARK: 칼로리
        
        let calHStack = UIStackView(arrangedSubviews: [calLabel, moreButtonForCalorie])
        calHStack.alignment = .firstBaseline
        moreButtonForCalorie.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        emptyView.addSubview(calHStack)
        calHStack.anchor(top: mealStack.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
        let calContainerView = UIView()
        calContainerView.layer.cornerRadius = 16
        emptyView.addSubview(calContainerView)
        calContainerView.backgroundColor = .white
        calContainerView.anchor(top: calHStack.bottomAnchor, left: stack.leftAnchor, bottom: emptyView.bottomAnchor,right: stack.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 60,paddingRight: 0, height: 160)
        calContainerView.addSubview(eatRoundedView)
        eatRoundedView.anchor(top: calContainerView.topAnchor, left: calContainerView.leftAnchor, right: calContainerView.rightAnchor, paddingTop: 26, paddingLeft: 22, paddingRight: 0, height: 14)
        calContainerView.addSubview(workoutRoundedView)
        workoutRoundedView.anchor(top: eatRoundedView.bottomAnchor, left: eatRoundedView.leftAnchor, right: eatRoundedView.rightAnchor, paddingTop: 13, paddingLeft: 0, paddingRight: 0, height: 14)
        calContainerView.addSubview(basicRoundedView)
        basicRoundedView.anchor(top: eatRoundedView.bottomAnchor, left: eatRoundedView.leftAnchor, right: eatRoundedView.rightAnchor, paddingTop: 13, paddingLeft: 0, paddingRight: 0, height: 14)
        
        //TODO: 중복
        let eatCal = shortRoundedView(color: CustomColor.subtlePurple ?? .purple)
        let eatMentVstack = shortMent(ment: "먹은 대사량", value: 1700)
        let 먹은칼로리 = UIStackView(arrangedSubviews: [eatCal, eatMentVstack])
        먹은칼로리.axis = .vertical
        먹은칼로리.spacing = 6
        먹은칼로리.alignment = .leading
        
        let basicCal = shortRoundedView(color: CustomColor.strongPurple ?? .purple)
        let basicMentVstack = shortMent(ment: "기초 대사량", value: 1700)
        let 기초칼로리 = UIStackView(arrangedSubviews: [basicCal, basicMentVstack])
        기초칼로리.axis = .vertical
        기초칼로리.spacing = 6
        기초칼로리.alignment = .leading
        
        let workOutCal = shortRoundedView(color: CustomColor.red ?? .red)
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
    
    @objc fileprivate func goSelectArmyViewController() {
        let selectArmyViewController = SelectArmyViewController()
        navigationController?.pushViewController(selectArmyViewController, animated: true)
    }
    
}

//MARK: 목표 collectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case purposeCollectionView:
            return 2
        case mealCollectionView:
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

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case purposeCollectionView:
            let width: CGFloat = Constants.purposeCellWidth
            let height: CGFloat = Constants.purposeCellHeight
            return CGSize(width: width, height: height)
        case mealCollectionView:
            let width: CGFloat = Constants.mealCellWidth
            let height: CGFloat = Constants.mealCellHeight
            return CGSize(width: width, height: height)
        default:
            return CGSize()
        }
    }
}

//MARK: 식단 collectionView

extension MainViewController {
    
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
    static let sideSpacing = 16.0
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
