//
//  MainViewController.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/06.
//

import UIKit
import FSCalendar
import RealmSwift

//TODO: scrollview

//전역일 글자

class MainViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource  {

    var 전역가까움: Double = 0.0
    var eatPercent = 0.0
    var workoutPercent = 0.0
    var basicPercent = 0.0
    
    var isMealCollectionView: String = ""// 부대
    var isMealData: Bool = false// 있는 부대인지
    
    var events2: [Date] = [] {
        willSet {
            calendar.reloadData()
        }
    }
    var calendar = FSCalendar()
    
    private var emptyView: UIView = {
       return UIView()
    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
          let activityIndicator = UIActivityIndicatorView()
          activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
          activityIndicator.center = self.view.center
          activityIndicator.hidesWhenStopped = true
          activityIndicator.style = UIActivityIndicatorView.Style.white
          activityIndicator.color = .black
          return activityIndicator
    }()
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
    
//    fileprivate let emptyButton: UIButton = {
//       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
//        button.tintColor = .clear
//        return button
//    }()
    
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
    
    fileprivate lazy var basicRoundedView: Bar = {
        let roundedView = Bar()
        roundedView.progressValue = Double(0)
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

//    fileprivate func shortMent(ment: String, value: Int) -> UIView {
//        let mentLabel = UILabel()
//        mentLabel.text = ment
//        mentLabel.font = .systemFont(ofSize: 13)
//        mentLabel.textColor = .black
//        let valueLabel = UILabel()
//        valueLabel.text = "\(value)kcal"
//        valueLabel.font = .systemFont(ofSize: 12)
//        valueLabel.textColor = .systemGray2
//        let vstack = UIStackView(arrangedSubviews: [mentLabel, valueLabel])
//        vstack.axis = .vertical
//        vstack.alignment = .leading
//        return vstack
//    }

    private let todayWorkoutCaloryLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray2
        label.text = "- kcal"
        return label
    }()
    
    private let todayBasicCaloryLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray2
        label.text = "- kcal"
        return label
    }()
    
    private let todayMealCaloryLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray2
        label.text = "- kcal"
        return label
    }()
    
    @objc fileprivate func goMoreMeal() {
        print("more meal")
        let vc = MainMealViewController()

        vc.isMealCollectionView = isMealCollectionView
        vc.delegate = self
        
        let nav = UINavigationController.init(rootViewController: vc)
//        navigationController?.pushViewController(vc, animated: true)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true)
    }
    
    @objc fileprivate func goMoreCalorie() {
//        mealOrNothing.backgroundColor = .red
//        mealStack.backgroundColor = .blue
        
        let vc = MainCalorieViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate lazy var workoutRoundedView: Bar = {
        let roundedView = Bar()
//        roundedView.progressValue = Double(basicPercent) + Double(workoutPercent)
        roundedView.progressValue = 0.0
        roundedView.progressColor = CustomColor.red ?? UIColor.red
        roundedView.trackColor = .clear
        return roundedView
    }()
    
    private var moreButtons: UIView = {
        let view = UIView()
        return view
    }()
    
    private let selectArmyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let selectArmyButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    fileprivate lazy var eatRoundedView: Bar = {
        let roundedView = Bar()
        roundedView.progressValue = 0.0
        roundedView.progressColor = CustomColor.subtlePurple ?? UIColor.purple
        roundedView.trackColor = .clear
        return roundedView
    }()
    
    private var mealStack: UIStackView = {
        return UIStackView()
    }()
    private let todoCollectionViewFlowLayout: UICollectionViewFlowLayout = {
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
    
     private lazy var todoCollectionView: UICollectionView = {
         let view = UICollectionView(frame: .zero, collectionViewLayout: todoCollectionViewFlowLayout)
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
    private let stack: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
       return view
    }()
    private var mealOrNothing: UIView = {
        return UIView()
        
    }()
    private let selectArmyView: UIView = {
        return UIView()
    }()
    
    private let 전역일들ContainerView: UIView = {
        return UIView()
    }()
    
    private let calContainerView = UIView()
    
    var mealData:Results<MealRealm>? = RealmManager.searchMealDataByDate(date: Date().formatterAppliedString())
    var todoData:Results<ToDoListRealm>? = RealmManager.notDoneTodoData()
//    {
//        willSet {
//            todoCollectionView.reloadData()
//        }
//    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
//        basicRoundedView.progressValue = 0.0
//        eatRoundedView.progressValue = 0.0
//        workoutRoundedView.progressValue = 0.0
        //다른 뷰컨에서 navi를 보이므로
        
        navigationController?.isNavigationBarHidden = true
        UserDefaultManager.saveDischargeDate(date: "2022-08-21".String2DateType()!)
        UserDefaultManager.saveStartDate(date: "2022-08-07".String2DateType()!)
        
//        RealmManager.deleteAlTodosData()
//        RealmManager.saveTodoListData(date: "2022-08-20".String2DateType()!, content: "1", isDone: false)
//        RealmManager.saveTodoListData(date: "2022-08-21".String2DateType()!, content: "2", isDone: false)
//        RealmManager.saveTodoListData(date: "2022-08-19".String2DateType()!, content: "0", isDone: false)
//        RealmManager.saveTodoListData(date: "2022-08-22".String2DateType()!, content: "3", isDone: false)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년M월dd일"
        
        dateLabel.text = dateFormatter.string(from: Date())
        
        if let finishDay = UserDefaultManager.loadDischargeDate(),
           let startDay = UserDefaultManager.loadStartDate() {
            print(Calendar.current.dateComponents([.day], from: startDay, to: finishDay))
            if let 시작부터전역일까지 = Calendar.current.dateComponents([.day], from: startDay, to: finishDay).day {
                if let 시작부터오늘까지 = Calendar.current.dateComponents([.day], from: startDay, to: Date().addingTimeInterval(60*60*9)).day {
                    print(시작부터전역일까지, 시작부터오늘까지)
                    print(Double(시작부터오늘까지)/Double(시작부터전역일까지))
                    전역가까움 = Double(시작부터오늘까지)/Double(시작부터전역일까지)
                    let col1 = UIColor(red: 170/255.0, green: 144/255.0, blue: 239/255.0, alpha: 1)
                    let col2 = UIColor(red: 113/255.0, green: 87/255.0, blue: 219/255.0, alpha: 1)
                    endDayBar.setGradient(color1: col2, color2: col1, width: (UIScreen.main.bounds.width - Constants.sideSpacing*4) * 전역가까움)
                    dDay.anchor(right:전역일들ContainerView.leftAnchor, paddingRight: 전역가까움 > 0.1 ? -(UIScreen.main.bounds.width - Constants.sideSpacing*3) * 전역가까움 : -(전역일.intrinsicContentSize.width + 60))
                    dDay.text = "D-\(시작부터전역일까지 - 시작부터오늘까지)"
                    dDay.layoutIfNeeded()
                }
            }
        }
        
        todoData = RealmManager.notDoneTodoData()
        
//        RealmManager.deleteAllWorkoutData()
//        RealmManager.saveWorkoutData(date: "20220815".String2DateTypeForWorkout()!, name: "팔굽", set: 3, count: 2, minutes: 3, seconds: 3, weight: 4, calories: 300)
//        RealmManager.saveWorkoutData(date: "20220816".String2DateTypeForWorkout()!, name: "팔굽2", set: 3, count: 2, minutes: 3, seconds: 3, weight: 4, calories: 200)
//        RealmManager.saveWorkoutData(date: "20220820".String2DateTypeForWorkout()!, name: "팔굽3", set: 3, count: 2, minutes: 3, seconds: 3, weight: 4, calories: 1000)
        
        
        let dateFormatterForWorkout = DateFormatter()
        dateFormatterForWorkout.locale = Locale(identifier: "ko_KR")
        dateFormatterForWorkout.dateFormat = "yyyyMMdd"
        
        let dateFormatterForMeal = DateFormatter()
        dateFormatterForMeal.locale = Locale(identifier: "ko_KR")
        dateFormatterForMeal.dateFormat = "yyyy-MM-dd"
        
        events2 = RealmManager.fetchSearchDidWorkoutDates() ?? []
        //viewwillappear
        updateMealAndCalView()
//        updateValues()
        
        updateMealRoundedView()
        
        UserDefaultManager.saveBMR(BMR: 1400)
        let bmr = UserDefaultManager.loadBMR() ?? 0
        basicPercent = Double(bmr) / 5000.0 * 100.0
        todayBasicCaloryLabel.text = "\(Double(bmr))kcal"
        basicRoundedView.progressValue = basicPercent
        print("check",basicPercent)
        print("percent", eatPercent, basicPercent, workoutPercent)
        
        if let workOut = RealmManager.searchWorkoutDataByDateK(date: dateFormatterForWorkout.string(from: Date())) {
            guard workOut.count != 0 else { return }
            print("qwqw운동칼로리", workOut[0].calories)
            let workoutCal = Double(Array(workOut.map { $0.calories ?? 0}).reduce(0, +))
            workoutPercent = workoutCal / 5000 * 100.0
            todayWorkoutCaloryLabel.text = "\(workoutCal)kcal"
            print("check",workoutPercent)
            workoutRoundedView.progressValue =  basicPercent + workoutPercent
        }
        
        
        
//        RealmManager.deleteAllWeightData()
        
        //몸무게
//        RealmManager.saveWeightData(date: Date().addingTimeInterval(60*60*9), weight: 40)
        
        //키
//        UserDefaultManager.saveHeight(height: 191)
//        print(UserDefaultManager.loadHeight())
        
        //bmr
//        UserDefaultManager.saveBMR(BMR: 1400)
//        let bmr = UserDefaultManager.loadBMR() ?? 0
//        basicPercent = Double(bmr) / 5000.0 * 100.0
//        todayBasicCaloryLabel.text = "\(Double(bmr))kcal"
//        basicRoundedView.progressValue = basicPercent
//        print("check",basicPercent)
//        print("percent", eatPercent, basicPercent, workoutPercent)
//        updateMealAndCalView()
//        view.layoutIfNeeded()
        
//        RealmManager.saveWeightData(date: "2022-08-22".String2DateType()!, weight: 33)
//        RealmManager.saveWeightData(date: "2022-08-11".String2DateType()!, weight: 45)
//        RealmManager.saveWeightData(date: "2022-08-24".String2DateType()!, weight: 50)
//        RealmManager.saveWeightData(date: "2022-08-19".String2DateType()!, weight: 56)
//        RealmManager.saveWeightData(date: "2022-08-27".String2DateType()!, weight: 55)
//        RealmManager.saveWeightData(date: "2022-08-27".String2DateType()!, weight: 59)
//        print("wewe",RealmManager.searchCurrentWeight())
        
//        print("qwerr",RealmManager.searchMealDataByDate(date: "2022-08-15")?.count)
//        print("qwerr",RealmManager.searchMealDataByDate(date: "2022-08-15"))
//        print(RealmManager.searchWorkoutDataByDateK(date: "20220815")?.count)
//        print(RealmManager.searchWorkoutDataByDateK(date: "20220819"))
        
//        let k = mealData.map{ $0.calories }
        
    }
    
    private func updateMealRoundedView() {
        print("viewWillAppear말고 update")
        let dateFormatterForMeal = DateFormatter()
        dateFormatterForMeal.locale = Locale(identifier: "ko_KR")
        dateFormatterForMeal.dateFormat = "yyyy-MM-dd"
        print("data!!!", RealmManager.searchMealDataByDate(date: dateFormatterForMeal.string(from: Date().addingTimeInterval(60*60*9))))
        
        print(RealmManager.allMealData()?.count)
        print(RealmManager.searchMealDataByDate(date: dateFormatterForMeal.string(from: Date().addingTimeInterval(60*60*9)))?.count)
        if let meal = RealmManager.searchMealDataByDate(date: dateFormatterForMeal.string(from: Date().addingTimeInterval(60*60*9))) {
            if meal.count == 0 {
                print("eatcheck no")
                eatPercent = 50.0
                todayMealCaloryLabel.text = "2000kcal"
            } else {
                print("cal", Double(meal[0].calories))
                let eatCal = Double(meal[0].calories)
                eatPercent = eatCal / 5000.0 * 100.0
                todayMealCaloryLabel.text = "\(eatCal)kcal"
                print("eatcheck", eatPercent)
            }
//            eatRoundedView.progressValue = eatPercent == 50.0 ? 12.0 : 40.0
            self.eatRoundedView.progressValue = eatPercent
            eatRoundedView.update()
            
//            self.eatRoundedView.draw(CGRect())
//            self.eatRoundedView.setNeedsDisplay()
            
        } else {
            eatPercent = 1.0
            todayMealCaloryLabel.text = "- kcal"
            self.eatRoundedView.progressValue = eatPercent
            eatRoundedView.update()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
//        print("2022-09-22".toDate()!)
//        UserDefaultManager.removeFirstTimeExperience()
//        RealmManager.deleteAllMealsData()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        UserDefaultManager.saveDischargeDate(date: "2022-08-18".String2DateType()!)

        calendar.delegate = self
        calendar.dataSource = self
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
//        Webservice.shared.fetchMeals300(army: "제5322부대")
        setupUI()
       
    }

    func setupUI() {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        emptyView.backgroundColor = .white
        scrollView.addSubview(emptyView)
        emptyView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor,bottom: scrollView.bottomAnchor ,right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0,paddingBottom: 0 ,paddingRight: 0)
        emptyView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        emptyView.backgroundColor = .systemGray6
    
        //MARK: (날짜 + 멘트)
//        let stack = UIStackView(arrangedSubviews: [dateLabel])
        stack.addSubview(dateLabel)
        dateLabel.anchor(left: stack.leftAnchor, paddingLeft: 4)
        dateLabel.centerY(inView: stack)
        emptyView.addSubview(stack)
        stack.anchor(top: emptyView.topAnchor, left: emptyView.leftAnchor, right: emptyView.rightAnchor, paddingTop: 40, paddingLeft: 16, paddingRight: 16)

        //MARK: 전역일 프로그레스
//        let 전역일들ContainerView = UIView()
        emptyView.addSubview(전역일들ContainerView)
        전역일들ContainerView.layer.cornerRadius = 16
        전역일들ContainerView.backgroundColor = .white
        전역일들ContainerView.setHeight(height: 100)
        전역일들ContainerView.anchor(top: stack.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 32.0, paddingLeft: 0, paddingRight: 0)
        
        let 전역일들 = UIStackView(arrangedSubviews: [전역일, dDay])
        전역일들ContainerView.addSubview(전역일들)
        전역일들.anchor(top: 전역일들ContainerView.topAnchor, left: 전역일들ContainerView.leftAnchor, paddingTop: 26.0, paddingLeft: 16.0)
        전역일들ContainerView.addSubview(endDayBar)
        endDayBar.anchor(top:전역일들.bottomAnchor, left: 전역일들ContainerView.leftAnchor, right: 전역일들ContainerView.rightAnchor,paddingTop: 12, paddingLeft: 16, paddingRight: 16)
//        let col1 = UIColor(red: 170/255.0, green: 144/255.0, blue: 239/255.0, alpha: 1)
//        let col2 = UIColor(red: 113/255.0, green: 87/255.0, blue: 219/255.0, alpha: 1)
//        endDayBar.setGradient(color1: col2, color2: col1, width: (UIScreen.main.bounds.width - Constants.sideSpacing*4) * 전역가까움)
//        print(전역가까움)
//        dDay.anchor(right:전역일들ContainerView.leftAnchor, paddingRight: 전역가까움 > 0.1 ? -(UIScreen.main.bounds.width - Constants.sideSpacing*3) * 전역가까움 : -(전역일.intrinsicContentSize.width + 60))
        
        //MARK: (목표들)
        let purposeStack = UIStackView(arrangedSubviews: [purposeLabel, todoCollectionView])
        purposeStack.axis = .vertical
        purposeStack.spacing = 8
        emptyView.addSubview(purposeStack)
        purposeStack.anchor(top: 전역일들ContainerView.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
        todoCollectionView.anchor(left: stack.leftAnchor, right: stack.rightAnchor, paddingLeft: 0, paddingRight: 0)
        todoCollectionView.setHeight(height: Constants.purposeCellHeight)
        todoCollectionView.backgroundColor = .systemGray6
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
        print(isMealCollectionView)
        let nextButton = UIButton()
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .touchUpInside)
        nextButton.tintColor = .black
        view.addSubview(nextButton)
        nextButton.anchor(right: calendar.rightAnchor, paddingRight: 16)
        nextButton.centerY(inView: calendar.calendarHeaderView)
        nextButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        calendar.placeholderType = .none//현재달만
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 13)
        
        //MARK: 식단
//      //MARK: viewwillAppear 칼로리
        updateMealAndCalView()
        
        //MARK: 칼로리 작은것들
        let mealCaloryMent = UILabel()
        mealCaloryMent.text = "먹은 칼로리"
        mealCaloryMent.font = .systemFont(ofSize: 13)
        mealCaloryMent.textColor = .black
        
        let eatMentVstack = UIStackView(arrangedSubviews: [mealCaloryMent, todayMealCaloryLabel])
        eatMentVstack.axis = .vertical
        eatMentVstack.alignment = .leading
        
        
        let eatCal = shortRoundedView(color: CustomColor.subtlePurple ?? .purple)
//        let eatMentVstack = shortMent(ment: "먹은 대사량", value: 1700)
        let 먹은칼로리 = UIStackView(arrangedSubviews: [eatCal, eatMentVstack])
        먹은칼로리.axis = .vertical
        먹은칼로리.spacing = 6
        먹은칼로리.alignment = .leading
        
        let basicCaloryMent = UILabel()
        basicCaloryMent.text = "기초 대사량"
        basicCaloryMent.font = .systemFont(ofSize: 13)
        basicCaloryMent.textColor = .black
        
        let basicCal = shortRoundedView(color: CustomColor.strongPurple ?? .purple)
//        let basicMentVstack = shortMent(ment: "기초 대사량", value: 1700)
        let basicMentVstack = UIStackView(arrangedSubviews: [basicCaloryMent, todayBasicCaloryLabel])
        basicMentVstack.axis = .vertical
        basicMentVstack.alignment = .leading
        
        let 기초칼로리 = UIStackView(arrangedSubviews: [basicCal, basicMentVstack])
        기초칼로리.axis = .vertical
        기초칼로리.spacing = 6
        기초칼로리.alignment = .leading
        
        let workoutCaloryMent = UILabel()
        workoutCaloryMent.text = "운동 칼로리"
        workoutCaloryMent.font = .systemFont(ofSize: 13)
        workoutCaloryMent.textColor = .black
        
        let workOutCal = shortRoundedView(color: CustomColor.red ?? .red)
//        let basicCal = shortRoundedView(color: CustomColor.strongPurple ?? .purple)
//        let basicMentVstack = shortMent(ment: "기초 대사량", value: 1700)
        let workoutMentVstack = UIStackView(arrangedSubviews: [workoutCaloryMent, todayWorkoutCaloryLabel])
        workoutMentVstack.axis = .vertical
        workoutMentVstack.alignment = .leading
        
        
//        let workOutCal = shortRoundedView(color: CustomColor.red ?? .red)
//        let workoutMentVstack = shortMent(ment: "운동 칼로리", value: 1700)
        let 운동칼로리 = UIStackView(arrangedSubviews: [workOutCal, workoutMentVstack])
        운동칼로리.axis = .vertical
        운동칼로리.spacing = 6
        운동칼로리.alignment = .leading
        
        let 세개칼로리스택 = UIStackView(arrangedSubviews: [먹은칼로리, 기초칼로리, 운동칼로리])
        calContainerView.addSubview(세개칼로리스택)
        세개칼로리스택.distribution = .equalCentering
        세개칼로리스택.anchor(top: basicRoundedView.bottomAnchor, left: calContainerView.leftAnchor, right: calContainerView.rightAnchor, paddingTop: 24, paddingLeft: 22, paddingRight: 16)
    }

    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @objc fileprivate func goSelectArmyViewController() {
        let selectArmyViewController = SelectArmyViewController()
        selectArmyViewController.isMealCollectionView = isMealCollectionView
        selectArmyViewController.delegate = self
        navigationController?.pushViewController(selectArmyViewController, animated: true)
    }
    
    fileprivate var mealHStack = UIStackView()
    
    fileprivate var mealEmptyView = UIView()
    
//    private func updateValues() {
//        selectArmyLabel.text =  isMealCollectionView.isEmpty ? "부대를\n선택하세요" : "해당 부대는 식단 정보를\n제공하지 않습니다"
//        print("qwe",!isMealCollectionView.isEmpty && isMealData)
//        mealOrNothing = !isMealCollectionView.isEmpty && isMealData ? mealCollectionView : selectArmyView
//
////        print("cc",mealStack.subviews.forEach{$0.removeFromSuperview()})
//
//        selectArmyView.backgroundColor = !isMealCollectionView.isEmpty && isMealData ? .clear : .white
////        mealStack.reloadInputViews()
////        mealStack.
//
//        mealStack = UIStackView(arrangedSubviews: [mealHStack, mealOrNothing])
//        print(mealEmptyView.subviews.count)
//        mealEmptyView.addSubview(mealStack)
//        mealEmptyView.subviews.enumerated().forEach { (i,k) in
//            if i == 0 {
//                k.removeFromSuperview()
//            }
//        }
//
//        mealStack.axis = .vertical
//        mealStack.spacing = 8
//        mealStack.backgroundColor = .clear
//        mealStack.anchor(top: mealEmptyView.topAnchor, left: mealEmptyView.leftAnchor, bottom: mealEmptyView.bottomAnchor, right: mealEmptyView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
//
////        emptyView.addSubview(mealStack)
////        mealStack.backgroundColor = .yellow
////        mealCollectionView.backgroundColor = .systemGray6
////        mealStack.axis = .vertical
////        mealStack.spacing = 8
////        mealStack.backgroundColor = .clear
////        print("p1_20", emptyView.subviews.count)
////        emptyView.addSubview(mealStack)
////        print("p1_21", emptyView.subviews.count)
////
////        mealStack.anchor(top: calendar.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
////
////        mealOrNothing.anchor(left: stack.leftAnchor, right: stack.rightAnchor, paddingLeft: 0, paddingRight: 0)
////        mealOrNothing.setHeight(height: Constants.mealCellHeight)
//
////        mealStack = UIStackView(arrangedSubviews: [mealHStack, mealOrNothing])
////        mealStack.anchor(top: calendar.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
////        view.layoutIfNeeded()
//    }
    
    private func updateMealAndCalView() {
//        moreButton.backgroundColor = .red
        moreButtons = moreButton
        moreButton.isHidden = isMealData ? false : true
        
        mealHStack = UIStackView(arrangedSubviews: [mealLabel, moreButtons])
//        mealHStack.backgroundColor = .blue
//        mealHStack.alignment = .center
        //TODO: 이해 mealHStack background color
        moreButtons.anchor(top: mealHStack.topAnchor, bottom: mealHStack.bottomAnchor, paddingTop: 0, paddingBottom: 0)
        moreButtons.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        selectArmyView.layer.cornerRadius = 16
        selectArmyLabel.text =  isMealCollectionView.isEmpty ? "부대를\n선택하세요" : "해당 부대는 식단 정보를\n제공하지 않습니다"
        selectArmyLabel.textColor = .systemBlue
        selectArmyLabel.numberOfLines = 0
        selectArmyLabel.textAlignment = .center
        print("p1_10", selectArmyView.subviews.count)
        selectArmyView.addSubview(selectArmyLabel)
        print("p1_11", selectArmyView.subviews.count)
        selectArmyLabel.centerX(inView: selectArmyView)
        selectArmyLabel.centerY(inView: selectArmyView)
        
//        print("qqqq",!isMealCollectionView.isEmpty && isMealData)
        mealOrNothing = !isMealCollectionView.isEmpty && isMealData ? mealCollectionView : selectArmyView
//        print("qqqqq", mealOrNothing)
        selectArmyView.backgroundColor = !isMealCollectionView.isEmpty && isMealData ? .clear : .white
        mealCollectionView.backgroundColor = .clear
//        print(isMealCollectionView.isEmpty)
//        print(isMealData)
//        print(!isMealCollectionView.isEmpty && isMealData)
        mealStack = UIStackView(arrangedSubviews: [mealHStack, mealOrNothing])
//        mealStack.backgroundColor = .yellow
//        mealCollectionView.backgroundColor = .systemGray6
        mealStack.axis = .vertical
        mealStack.spacing = 8
        mealStack.backgroundColor = .clear
        print("p1_20", emptyView.subviews.count)
        
        mealEmptyView.addSubview(mealStack)
        mealStack.anchor(top: mealEmptyView.topAnchor, left: mealEmptyView.leftAnchor, bottom: mealEmptyView.bottomAnchor, right: mealEmptyView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        emptyView.addSubview(mealEmptyView)
        mealEmptyView.anchor(top: calendar.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
//        mealEmptyView.backgroundColor = .red
        
        
        
//        emptyView.addSubview(mealStack)
//        print("p1_21", emptyView.subviews.count)
//        mealStack.anchor(top: calendar.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
        
        
        
        mealOrNothing.anchor(left: stack.leftAnchor, right: stack.rightAnchor, paddingLeft: 0, paddingRight: 0)
        mealOrNothing.setHeight(height: Constants.mealCellHeight)
        print("p1_22", mealOrNothing.subviews.count)
        mealOrNothing.addSubview(activityIndicator)
        print("p1_23", mealOrNothing.subviews.count)
        print("p2",mealOrNothing.subviews.count)
        activityIndicator.centerY(inView: mealOrNothing)
        activityIndicator.centerX(inView: mealOrNothing)
//        mealOrNothing.backgroundColor = !isMealCollectionView.isEmpty && isMealData ? .clear : .white
        

        //버튼추가 updatemealand..
        if (isMealCollectionView.isEmpty || isMealCollectionView == "없음") && !isMealData {
            emptyView.addSubview(selectArmyButton)
            selectArmyButton.addTarget(self, action: #selector(goSelectArmyViewController), for: .touchUpInside)
            selectArmyButton.backgroundColor = .clear
            selectArmyButton.anchor(top: mealOrNothing.topAnchor, left: mealOrNothing.leftAnchor, bottom: mealOrNothing.bottomAnchor, right: mealOrNothing.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        }
    
        //MARK: 칼로리
        setCalroyView()
        
    }
    private func setCalroyView() {
        
        
        let calHStack = UIStackView(arrangedSubviews: [calLabel, moreButtonForCalorie])
        calHStack.alignment = .firstBaseline
        moreButtonForCalorie.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        print("p1_0",emptyView.subviews.count)
        emptyView.addSubview(calHStack)
        print("p1_1",emptyView.subviews.count)
//        calHStack.anchor(top: mealStack.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)
        calHStack.anchor(top: mealEmptyView.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingRight: 0)

        calContainerView.layer.cornerRadius = 16
        print("p1_2", emptyView.subviews.count)
        emptyView.addSubview(calContainerView)
        print("p1_3",emptyView.subviews.count)
        calContainerView.backgroundColor = .white
        calContainerView.anchor(top: calHStack.bottomAnchor, left: stack.leftAnchor, bottom: emptyView.bottomAnchor,right: stack.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 60,paddingRight: 0, height: 160)
        print("p1_4", calContainerView.subviews.count)
        calContainerView.addSubview(eatRoundedView)
        print("p1_5", calContainerView.subviews.count)
        eatRoundedView.anchor(top: calContainerView.topAnchor, left: calContainerView.leftAnchor, right: calContainerView.rightAnchor, paddingTop: 26, paddingLeft: 22, paddingRight: 0, height: 14)
        
//        eatRoundedView.progressValue = 0.0
        print("p1_6", calContainerView.subviews.count)
        calContainerView.addSubview(workoutRoundedView)
        print("p1_7", calContainerView.subviews.count)
        workoutRoundedView.anchor(top: eatRoundedView.bottomAnchor, left: eatRoundedView.leftAnchor, right: eatRoundedView.rightAnchor, paddingTop: 13, paddingLeft: 0, paddingRight: 0, height: 14)
        print("p1_8", calContainerView.subviews.count)
        calContainerView.addSubview(basicRoundedView)
        print("p1_9", calContainerView.subviews.count)
//        workoutRoundedView.progressValue = 0.0
        
        basicRoundedView.anchor(top: eatRoundedView.bottomAnchor, left: eatRoundedView.leftAnchor, right: eatRoundedView.rightAnchor, paddingTop: 13, paddingLeft: 0, paddingRight: 0, height: 14)
    }
    
}

//MARK: 목표 collectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case todoCollectionView:
            return todoData?.count ?? 0
        case mealCollectionView:
            return mealData?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case todoCollectionView:
            print("cell purposeCollectionView")
            guard let cell = todoCollectionView.dequeueReusableCell(withReuseIdentifier: PurposeCollectionViewCell.cellID, for: indexPath) as? PurposeCollectionViewCell else { return UICollectionViewCell() }
//            let cell = PurposeCollectionViewCell(todo:  todoData[indexPath.row])
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy.MM.dd"
            cell.delegate = self
            cell.backgroundColor = .white
            guard let todoData = todoData else {
                return cell
            }
            cell.todoID = todoData[indexPath.row].dateSorting
            cell.dateLabel.text = dateFormatter.string(from: todoData[indexPath.row].date)
            cell.purposeLabel.text = todoData[indexPath.row].content
            cell.thumbButton.tintColor = todoData[indexPath.row].isDone == false ? .gray : .none
            return cell
        case mealCollectionView:
            print("cell mealCollectionView")
            guard let cell = mealCollectionView.dequeueReusableCell(withReuseIdentifier: mealCollectionViewCell.cellID, for: indexPath) as? mealCollectionViewCell else { return UICollectionViewCell() }
            cell.mealLabel.text = ["조식", "중식", "석식"][indexPath.row]
//            cell.반찬들 = mealData[indexPath.row].mealArray
//            cell.calLabel.text = "\(mealData[indexPath.row].calories)kcal"
            cell.backgroundColor = .white
            guard let mealData = mealData else {
                return cell
            }
            let array = mealData[indexPath.row].mealArray
            
            if array.count > 0 {
                cell.label1.text = array[0]
            }
            if array.count > 1 {
                cell.label2.text = array[1]
            }
            if array.count > 2 {
                cell.label3.text = array[2]
            }
            if array.count > 3 {
                cell.label4.text = array[3]
            }
            if array.count > 4 {
                cell.label5.text = array[4]
            }
            if array.count > 5 {
                cell.label6.text = array[5]
            } else
            if array.count > 6 {
                cell.label7.text = array[6]
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case todoCollectionView:
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
            return .black
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
        
        if events2.contains(date.addingTimeInterval(60*60*9)) {
            return CustomColor.calendarRedColor
        } else {
            print("not")
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
    func getThumbUp(todoID: Int) {
        RealmManager.todoDoneAt(todoID)
        todoCollectionView.isScrollEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.14) {
            self.todoCollectionView.reloadData()
            self.todoCollectionView.isScrollEnabled = true
        }
//        print(RealmManager.notDoneTodoData().count)
//        print(todoData.count)
//        print("get thumb up in vc")
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

extension MainViewController: ArmySelection {
    func selectArmy(selectedArmy: String) {
        //TODO
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
        selectArmyLabel.isHidden = true
        selectArmyView.backgroundColor = .clear
        moreButton.isUserInteractionEnabled = false
        moreButton.isHidden = true
//        moreButtons = emptyButton
        selectArmyButton.isUserInteractionEnabled = false
//        isMealData = isMealCollectionView == "없음" ? false : true
//        moreButtons.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        Webservice.shared.fetchMeals300(army: selectedArmy) {
            DispatchQueue.main.async {
                
                print("qqqqqqq", selectedArmy)
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "yyyy-MM-dd"
                dateformatter.locale = Locale(identifier: "ko_KR")
                self.mealData = RealmManager.searchMealDataByDate(date: dateformatter.string(from: Date().addingTimeInterval(60*60*9)))
                self.isMealCollectionView = selectedArmy
                self.isMealData = selectedArmy == "없음" ? false : true
                self.mealCollectionView.reloadData()
                self.updateMealAndCalView()
//                self.updateValues()
                if selectedArmy != "없음" {
                    self.selectArmyLabel.isHidden = true
                    self.mealCollectionView.isHidden = false
    //                self.selectArmyView.isHidden = true
    //                self.mealOrNothing.backgroundColor = .clear
                    self.selectArmyView.backgroundColor = .clear
                    self.selectArmyButton.isUserInteractionEnabled = false
                    self.moreButton.isHidden = false
//                    self.moreButtons = self.moreButton
                    self.moreButton.isUserInteractionEnabled = true
                    self.updateMealRoundedView()
                } else {
                    self.selectArmyLabel.isHidden = false
                    self.mealCollectionView.isHidden = true
                    self.selectArmyView.backgroundColor = .white
                    self.selectArmyButton.isUserInteractionEnabled = true
                    self.moreButton.isHidden = true
//                    self.moreButtons = self.emptyButton
                    self.moreButton.isUserInteractionEnabled = false
                    self.updateMealRoundedView()
                    
                }
                
                
                
                self.activityIndicator.stopAnimating()
                
                
                
//                self.updateMealView()
//                self.view?.reloadInputViews()
//                self.view.updateConstraints()
//                self.loadViewIfNeeded()
            }
        }
    }
}
