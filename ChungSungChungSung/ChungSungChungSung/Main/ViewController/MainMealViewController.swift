//
//  MainMealViewController.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/10.
//

import UIKit
//item size
class MainMealViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
//    fileprivate let monthLabel: UILabel = {
//       let label = UILabel()
//        return label
//    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
          let activityIndicator = UIActivityIndicatorView()
          activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//          activityIndicator.center = self.view.center
          activityIndicator.hidesWhenStopped = true
          activityIndicator.style = UIActivityIndicatorView.Style.white
          activityIndicator.color = .black
//          activityIndicator.startAnimating()
          return activityIndicator
    }()
    
    var mealData = RealmManager.searchMealDataByDate(date: Date().formatterAppliedString())
    
    private let mainMealTableViewCellID = "mainMealTableViewCellID"
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    fileprivate var tableView: UITableView = UITableView()
    var isMealCollectionView: String = ""
    weak var delegate: ArmySelection?
    fileprivate let previousButton: UIButton = {
        let previousButton = UIButton()
        previousButton.addTarget(MainMealViewController.self, action: #selector(previousTapped), for: .touchUpInside)
//        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
//        let boldPrevioud = UIImage(systemName: "chevron.left", withConfiguration: boldConfig)?.withRenderingMode(.alwaysTemplate)
//        previousButton.setImage(boldPrevioud, for: .normal)
        previousButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        
        
        return previousButton
    }()
    
    fileprivate let nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.addTarget(MainMealViewController.self, action: #selector(nextTapped), for: .touchUpInside)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let boldRight = UIImage(systemName: "chevron.right", withConfiguration: boldConfig)
        nextButton.setImage(boldRight, for: .normal)
        
        return nextButton
    }()
    
    @objc func previousTapped()
    {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
    }
    @objc func nextTapped()
    {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
    var selectedDate = Date()
    
    
    var totalSquares = [Date]()
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let view = UICollectionViewFlowLayout()
        view.minimumLineSpacing = Constants.weekLineSpacing
        view.scrollDirection = .horizontal
        return view
      }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        view.register(CalendarCell.self, forCellWithReuseIdentifier: "calCell")
        view.dataSource = self
        view.delegate = self
      return view
    }()
    
    func setWeekView()
    {
        totalSquares.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        while (current < nextSunday)
        {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        headerLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        
        
        self.collectionView.reloadData()
        self.tableView.reloadData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        print(isMealCollectionView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let changeArmyButton = UIButton()
//        changeArmyButton.setTitle("변경", for: .normal)
//        changeArmyButton.addTarget(self, action: #selector(changeArmy), for: .touchUpInside)
        let editBarButton = UIBarButtonItem(title: "변경", style: .plain, target: self, action: #selector(changeArmy))
        
//        let navigationBarAppearance = UINavigationBarAppearance()
//        navigationBarAppearance.shadowColor = .clear
        
        navigationItem.title = "식단"
        navigationController?.navigationBar.topItem?.backButtonTitle = "메인"
        
        self.navigationItem.rightBarButtonItems = [editBarButton]
        tableView.register(MainMealTableViewCell.self, forCellReuseIdentifier: mainMealTableViewCellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.rowHeight = 140
        tableView.backgroundColor = .systemGray6
        tableView.sectionHeaderTopPadding = 12
        
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12)
        
        let previousButton = UIButton()
        previousButton.addTarget(self, action: #selector(previousTapped), for: .touchUpInside)
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let boldLeft = UIImage(systemName: "chevron.left", withConfiguration: boldConfig)
        previousButton.setImage(boldLeft, for: .normal)
        previousButton.tintColor = .systemGray
        
        let nextButton = UIButton()
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        nextButton.tintColor = .systemGray
        let boldRight = UIImage(systemName: "chevron.right", withConfiguration: boldConfig)
        nextButton.setImage(boldRight, for: .normal)
        
        let calenderHeaderStack = UIStackView(arrangedSubviews: [previousButton,headerLabel,nextButton])
        calenderHeaderStack.spacing = 35
        containerView.addSubview(calenderHeaderStack)
        calenderHeaderStack.anchor(top: containerView.topAnchor, paddingTop: 24, paddingLeft: 0)
        calenderHeaderStack.centerX(inView: containerView)
        
        containerView.addSubview(collectionView)
        collectionView.anchor(top: calenderHeaderStack.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 19, paddingLeft: 0, paddingRight: 0, height: 74)
        collectionView.backgroundColor = .systemGray6
        setWeekView()
        
        view.addSubview(tableView)
        tableView.anchor(top: collectionView.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.addSubview(activityIndicator)
        activityIndicator.centerX(inView: tableView)
        activityIndicator.centerY(inView: tableView)
        
//        tableView.addSubview(activityIndicator)
//        activityIndicator.centerX(inView: tableView)
//        activityIndicator.centerY(inView: tableView)
        
        view.backgroundColor = .systemGray6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(totalSquares)
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        let date = totalSquares[indexPath.item]
        cell.weekdayLabel.text = CalendarHelper().weekDataAt(indexPath.row)
        cell.dayLabel.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(date == selectedDate) {
//            cell.backgroundColor = UIColor.진보라
            let view = UIView()
            cell.backgroundView = view
            let col1 = UIColor(red: 170/255.0, green: 144/255.0, blue: 239/255.0, alpha: 1)
            let col2 = UIColor(red: 113/255.0, green: 87/255.0, blue: 219/255.0, alpha: 1)
            view.setGradient(color1: col1, color2: col2, bounds: cell.bounds, orientation: .vertical)
            cell.dayLabel.textColor = .white
            cell.weekdayLabel.textColor = .white
        }
        
        else {
            let view = UIView()
            cell.backgroundView = view
            cell.dayLabel.textColor = .black
            cell.weekdayLabel.textColor = .black
        }
       
        return cell
    }
    
    @objc fileprivate func changeArmy() {
        let selectArmyViewController = SelectArmyViewController()
        selectArmyViewController.delegate = delegate
//        selectArmyViewController.delegateInMealView = self
        selectArmyViewController.pastViewName = "식단"
        selectArmyViewController.isMealCollectionView = isMealCollectionView
        navigationController?.pushViewController(selectArmyViewController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedDate == totalSquares[indexPath.item] { return }
        selectedDate = totalSquares[indexPath.item]
//        DispatchQueue(label: "realm").async {
//        let mealData = RealmManager.searchMealDataByDate(date: self.selectedDate.formatterAppliedString())
//        }
        mealData = RealmManager.searchMealDataByDate(date: self.selectedDate.formatterAppliedString())
        
        print(self.selectedDate.formatterAppliedString())
        print(mealData)
        
        collectionView.reloadData()
        tableView.reloadData()
    }
}
extension MainMealViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mealData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: mainMealTableViewCellID, for: indexPath) as? MainMealTableViewCell
        else { return UITableViewCell() }
        print(indexPath.section)
        cell.whenMealLabel.text = ["조식", "중식", "석식"][indexPath.section]
//        cell.calorieLabel.text = "\(mealData[indexPath.section].calories)kcal"
        
        print("qwer", indexPath.section)
//        print("qwer",cell.mealStrings.isEmpty)
//        print("qwer",cell.mealStrings)
//        print("qwer")
//        cell.mealStrings = cell.mealStrings.isEmpty ? mealData[indexPath.section].mealArray : []
//        cell.label1.text = mealData[indexPath.section].mealArray[0]
        guard let mealData = mealData else { return cell }
        print(mealData[indexPath.section].mealArray)
        let array = mealData[indexPath.section].mealArray
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
//        cell.render(mealData[indexPath.section].mealArray)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
}

extension MainMealViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 6 * Constants.weekLineSpacing) / 7
        let height = (collectionView.frame.size.height)
        return  CGSize(width: width, height: height)
    }
}

class CalendarHelper {
    
    let calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func weekDataAt(_ index: Int) -> String {
        ["월", "화", "수", "목", "금", "토", "일"][index]
    }
    func minusMonth(date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func monthString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func timeString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int
    {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func dayOfMonth(date: Date) -> Int
    {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(date: Date) -> Date
    {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int
    {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    func addDays(date: Date, days: Int) -> Date
    {
        return calendar.date(byAdding: .day, value: days, to: date)!
    }
    
    func sundayForDate(date: Date) -> Date
    {
        var current = date
        let oneWeekAgo = addDays(date: current, days: -7)
        
        while(current > oneWeekAgo)
        {
            let currentWeekDay = calendar.dateComponents([.weekday], from: current).weekday
            if(currentWeekDay == 1)
            {
                return current
            }
            current = addDays(date: current, days: -1)
        }
        return current
    }
    
}

class CalendarCell: UICollectionViewCell {
    
    let gradientLayer = CAGradientLayer()
    
    let weekdayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.middleText - 6, weight: .light)
        return label
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.middleText , weight: .light)
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override func layoutSublayers(of layer: CALayer) {
//        
//        super.layoutSublayers(of: self.layer)
////        let view = UIView()
////        self.backgroundView = view
////        let col1 = UIColor(red: 170/255.0, green: 144/255.0, blue: 239/255.0, alpha: 1)
////        let col2 = UIColor(red: 113/255.0, green: 87/255.0, blue: 219/255.0, alpha: 1)
////        view.setGradient(color1: col1, color2: col2, bounds: self.bounds)
////        let colorSet = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0),
////                                UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)]
////        let location = [0.2, 1.0]
////
////        self.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
//        }
    
    
    fileprivate func setupUI() {
//        self.layer.cornerRadius = 21
        
        let vstack = UIStackView(arrangedSubviews: [weekdayLabel, dayLabel])
        vstack.alignment = .center
        vstack.axis = .vertical
        vstack.spacing = 10
        
        contentView.addSubview(vstack)
        vstack.centerX(inView: contentView)
        vstack.centerY(inView: contentView)
    }
}

//extension MainMealViewController: ArmySelectionInMealView {
//    func selectArmy(selectedArmy: String) {
////        let dateformatter = DateFormatter()
////        dateformatter.dateFormat = "yyyy-MM-dd"
////        dateformatter.locale = Locale(identifier: "ko_KR")
//
//        activityIndicator.startAnimating()
//        collectionView.isUserInteractionEnabled = false
//        Webservice.shared.fetchMeals300(army: selectedArmy) {
//            DispatchQueue.main.async {
//                let dateformatter = DateFormatter()
//                dateformatter.dateFormat = "yyyy-MM-dd"
//                dateformatter.locale = Locale(identifier: "ko_KR")
//
//                self.mealData = RealmManager.searchMealDataByDate(date: dateformatter.string(from: Date()))
//                self.collectionView.isUserInteractionEnabled = true
////                self.selectArmyLabel.isHidden = false
////                self.selectArmyButton.isUserInteractionEnabled = true
////                self.moreButton.isHidden = false
////                self.moreButton.isUserInteractionEnabled = true
////                self.isMealCollectionView = selectedArmy
////                self.isMealData = self.isMealCollectionView == "없음" ? false : true
//                self.activityIndicator.stopAnimating()
//                self.tableView.reloadData()
////                self.mealCollectionView.reloadData()
////                self.setupUI()
//            }
//        }
//
//    }
//}
