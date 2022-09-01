//
//  ProfileViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/12.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {
    private let profileViewTitle = "프로필"
    
//    private var goalList = GoalData().list
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var profileTableView: UITableView!
    var unit: String?
    var dischargeDate: Date?
    var age: Int?
    var weight: Int?
    var height : Int?
    var todo: ToDoListRealm?
    var badgeNames: [String]?
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let badges = RealmManager.searchBadges() {
            badgeNames = badges.map { $0.title }
            profileTableView.reloadData()
        }
        self.tabBarController?.tabBar.items![3].badgeValue = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        RealmManager.deleteAllWeightData2()
//        UserDefaultManager.saveUnit(unit: "제 1234부대")
//        print(UserDefaultManager.loadUnit())
        unit = UserDefaultManager.loadUnit()
        
//        UserDefaultManager.saveDischargeDate(date: Date().addingTimeInterval(60*60*9))
//        print(UserDefaultManager.loadDischargeDate2())
        dischargeDate = UserDefaultManager.loadDischargeDate2()
        
//        UserDefaultManager.saveAge(age: 22)
//        print(UserDefaultManager.loadAge())
        age = UserDefaultManager.loadAge()
        
//        RealmManager.saveWeightData(date: Date().addingTimeInterval(60*60*9), weight: 23)
//        RealmManager.saveWeightData(date: Date().addingTimeInterval(60*60*25), weight: 33)
//        print(RealmManager.searchCurrentWeight2())
        weight = RealmManager.searchCurrentWeight2()

//        UserDefaultManager.saveHeight(height: 33)
//        print(UserDefaultManager.loadHegiht2())
        height = UserDefaultManager.loadHegiht2()

        
//        RealmManager.saveTodoListData(date: Date().addingTimeInterval(60*60*1), content: "1", isDone: true)
//        RealmManager.saveTodoListData(date: Date().addingTimeInterval(60*60*2), content: "2", isDone: false)
//        RealmManager.saveTodoListData(date: Date().addingTimeInterval(60*60*3), content: "2", isDone: false)
//        RealmManager.saveTodoListData(date: Date().addingTimeInterval(60*60*4), content: "2", isDone: false)
//        RealmManager.saveTodoListData(date: Date().addingTimeInterval(60*60*5), content: "2", isDone: false)
//        RealmManager.saveTodoListData(date: Date().addingTimeInterval(60*60*6), content: "52", isDone: false)
        
//        print(RealmManager.searchTodo())//둘다하자
//        print(RealmManager.searchCurrentTodo()?.content)
        todo = RealmManager.searchCurrentTodo()
//        RealmManager.saveBadgeData(date: Date().addingTimeInterval(60*60*9), title: "우리의 시작")
//        RealmManager.saveBadgeData(date: Date().addingTimeInterval(60*60*9), title: "첫 기록의 기쁨")
        print(Realm.Configuration.defaultConfiguration.fileURL!)
//        print(RealmManager.searchBadges())
//        badges = RealmManager.searchBadges()
        
        
        configNavigationTitle()
        self.view.backgroundColor = CustomColor.bgGray
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        profileTableView.backgroundColor = CustomColor.bgGray
        profileTableView.contentInset.top = 35
        
        let backBarButtonItem = UIBarButtonItem(title: profileViewTitle, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        let armyInfoTableViewCellNib = UINib(nibName: "ArmyInfoTableViewCell", bundle: nil)
        let bodyInfoTableViewCellNib = UINib(nibName: "BodyInfoTableViewCell", bundle: nil)
        let goalsTableViewCellNib = UINib(nibName: "GoalsTableViewCell", bundle: nil)
        let badgeTableViewCellNib = UINib(nibName: "BadgeTableViewCell", bundle: nil)
        
        profileTableView.register(armyInfoTableViewCellNib, forCellReuseIdentifier: "armyInfoTableViewCell")
        profileTableView.register(bodyInfoTableViewCellNib, forCellReuseIdentifier: "bodyInfoTableViewCell")
        profileTableView.register(goalsTableViewCellNib, forCellReuseIdentifier: "goalsTableViewCell")
        profileTableView.register(badgeTableViewCellNib, forCellReuseIdentifier: "badgeTableViewCell")
    }
    
    private func configNavigationTitle() {
//        let viewWidth = self.view.bounds.width - 80
//        let profileViewTitleLabel = UILabel(frame: CGRect(x: 25, y: 0, width: viewWidth, height: 20))
//        profileViewTitleLabel.textAlignment = .left
//        profileViewTitleLabel.font = UIFont.boldSystemFont(ofSize: 28)

        navigationItem.title = profileViewTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

protocol GoalsDetailViewDelegate {
    func didTapGoalsMoreButton()
}

protocol BadgeDetailViewDelegate {
    func didTapBadgeMoreButton()
}

extension ProfileViewController: GoalsDetailViewDelegate, BadgeDetailViewDelegate {
    func didTapGoalsMoreButton() {
        guard let goalsDetailView = UIStoryboard(name: "GoalsDetail", bundle: .main).instantiateViewController(withIdentifier: "GoalsDetailViewController") as? GoalsDetailViewController else { return }
        
//        print("qwer", RealmManager.doneTodoData2()?.count, RealmManager.notDoneTodoData2()?.count)
        goalsDetailView.delegate = self
        goalsDetailView.deleteDelegate = self
//        goalsDetailView.doneTodos = RealmManager.doneTodoData2()
//        
//        goalsDetailView.notDoneTodos = RealmManager.notDoneTodoData2()
        self.navigationController?.pushViewController(goalsDetailView, animated: true)
    }
    
    func didTapBadgeMoreButton() {
        guard let badgeDetailView = UIStoryboard(name: "BadgeDetail", bundle: .main).instantiateViewController(withIdentifier: "BadgeDetailViewController") as? BadgeDetailViewController else { return }
        
        self.navigationController?.pushViewController(badgeDetailView, animated: true)
        if let badgeNames = badgeNames {
            badgeDetailView.badgeNames = badgeNames
            
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
//    func didTapGoalsMoreButton() {
//        guard let goalsDetailView = UIStoryboard(name: "GoalsDetail", bundle: .main).instantiateViewController(withIdentifier: "GoalsDetailViewController") as? GoalsDetailViewController else { return }
//        self.navigationController?.pushViewController(goalsDetailView, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "armyInfoTableViewCell", for: indexPath) as? ArmyInfoTableViewCell else { return UITableViewCell() }
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy.MM.dd"
            
//            cell.armyCorpsNameLabel.text = unit ?? "부대가 등록되어있지 않습니다."
            cell.armyCorpsNameLabel.text = ""
            if let dischargeDate = dischargeDate {
                cell.dischargeDateLabel.text = dateFormatter.string(from: dischargeDate)
            } else {
                cell.dischargeDateLabel.text = "전역일이 등록되어있지 않습니다."
            }
            cell.delegate = self
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "bodyInfoTableViewCell", for: indexPath) as? BodyInfoTableViewCell else { return UITableViewCell() }
            if let age = age {
                cell.ageLabel.text = "\(age)"
            } else {
                cell.ageLabel.text = "나이가 등록되어있지 않습니다."
            }
            
            if let h = height,
               let w = weight {
                cell.heightAndWeightLabel.text = "\(h)cm / \(w)kg"
            } else {
                cell.heightAndWeightLabel.text = "- cm / - kg"
            }
            cell.delegate = self
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalsTableViewCell", for: indexPath) as? GoalsTableViewCell else { return UITableViewCell() }
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy.MM.dd"
            
            if let todo = todo {
                cell.goalLabel.text = todo.content
//                print("qwer", dateFormatter.string(from: todo.date))
                cell.goalSavedDateLabel.text = dateFormatter.string(from: todo.date)
                
            } else {
                cell.goalLabel.text = "목표를 설정하세요."
                cell.goalSavedDateLabel.text = dateFormatter.string(from: Date())
            }
//            cell.goalLabel.text = goalList[0].content
//            cell.goalSavedDateLabel.text = goalList[0].date
            cell.goalsDetailViewDelegate = self
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "badgeTableViewCell", for: indexPath) as? BadgeTableViewCell else { return UITableViewCell() }
            cell.badgeNames = badgeNames ?? []
            cell.badgeDetailViewDelegate = self
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 112
        } else if indexPath.row == 1 {
            return 152
        } else if indexPath.row == 2 {
            return 174
        } else {
            return 300
//            return UITableView.automaticDimension
            // TODO: 뱃지 많아지면 자동으로 CollectionView 높이만큼 이 TableViewCell 높이도 길어졌으면 좋겠음.
        }
    }
    
}

extension UserDefaultManager {
    static func loadUnit() -> String? {
        guard let unit = UserDefaults.standard.object(forKey: "unit") as? String else {
            return nil
        }
        return unit
    }
    
    static func loadAge() -> Int? {
        guard let age = UserDefaults.standard.object(forKey: "age") as? Int else {
            return nil
        }
        return age
    }
    static func loadDischargeDate2() -> Date? {
        guard let date = UserDefaults.standard.object(forKey: "dischargeDate") as? Date else {
            return nil
        }
        return date
    }
    static func loadHegiht2() -> Int? {
        guard let height = UserDefaults.standard.object(forKey: "height") as? Int else {
            return nil
        }
        return height
    }
}

extension RealmManager {
    
    static func searchTodo() -> Results<ToDoListRealm> {
        let realm = localRealm.objects(ToDoListRealm.self)
        return realm
    }
    
    static func searchCurrentWeight2() -> Int? {
        let localRealm = try! Realm()
        let realm = localRealm.objects(WeightRealm.self)
//        print("렘\(realm)")
        let target = realm.sorted(byKeyPath: "dateSorting", ascending: false)
        if target.count == 0 {
            return nil
        } else {
            return target[0].weight
        }
    }
    
    static func notDoneTodoData2() -> Results<ToDoListRealm>? {
        let localRealm = try! Realm()
        let realm = localRealm.objects(ToDoListRealm.self)
                            .filter("isDone = false")
                            .sorted(byKeyPath: "dateSorting", ascending: false)
        if realm.count == 0 {
            return nil
        } else {
            return realm
        }
    }

    static func doneTodoData2() -> Results<ToDoListRealm>? {
        let localRealm = try! Realm()
        let realm = localRealm.objects(ToDoListRealm.self)
                            .filter("isDone = true")
                            .sorted(byKeyPath: "dateSorting", ascending: false)
        if realm.count == 0 {
            return nil
        } else {
            return realm
        }
    }
    
    static func searchCurrentTodo() -> ToDoListRealm? {
        let localRealm = try! Realm()
        let realm = localRealm.objects(ToDoListRealm.self)
        let target = realm.sorted(byKeyPath: "dateSorting", ascending: false)
        if target.count == 0 {
            return nil
        } else {
            return target[0]
        }
    }
    
    static func searchBadges() -> Results<BadgeRealm>? {
        let localRealm = try! Realm()
        let realm = localRealm.objects(BadgeRealm.self)
        if realm.count == 0 {
            return nil
        } else {
            return realm
        }
    }
    
    
}

extension ProfileViewController: EditDischargeViewRelated {
    func goDischargeDetailVC(date: String) {
        guard let dischargeDetail = UIStoryboard(name: "DischargeDetail", bundle: .main).instantiateViewController(withIdentifier: "DischargeDetailViewController") as? DischargeDetailViewController else { return }
        dischargeDetail.delegate = self
        dischargeDetail.date = date
        navigationController?.pushViewController(dischargeDetail, animated: true)
    }
}

extension ProfileViewController: DischargeEdit {
    func changeDischarge() {
        dischargeDate = UserDefaultManager.loadDischargeDate2()
//        print(UserDefaultManager.loadDischargeDate2())
        profileTableView.reloadData()
    }
}

extension ProfileViewController: EditBodyViewRelated {
    func goBodyInfoProfileVC() {
        guard let bodyDetail = UIStoryboard(name: "ProfileBodyInfo", bundle: .main).instantiateViewController(withIdentifier: "BodyInfoProfileViewController") as? BodyInfoProfileViewController else { return }
        bodyDetail.delegate = self
        if let age = age,
           let height = height,
           let weight = weight {
            bodyDetail.info = [age, height, weight]
        } 
        
        navigationController?.pushViewController(bodyDetail, animated: true)
    }

}

extension ProfileViewController: EditBodyViewRelatedForBodyVC {
    func completeEdit() {
        age = UserDefaultManager.loadAge()
        weight = RealmManager.searchCurrentWeight2()
        height = UserDefaultManager.loadHegiht2()
        
        profileTableView.reloadData()
//        66 + (13.8 x 몸무게(kg)) + (5 x 키(cm)) - (6.8 x 나이)
        guard let weight = weight,
              let height = height,
              let age = age else {
            UserDefaultManager.saveBMR(BMR: 1600)
            return
        }
        
        let a = 13.8 * Double(weight)
        let b = 5 * Double(height)
        let c = 6.8 * Double(age)
        let cal = 66 + a + b - c
        
        UserDefaultManager.saveBMR(BMR: Int(cal))
    }
}

extension RealmManager {
    static func deleteAllWeightData2() {
        
        let localRealm = try! Realm()
        let alls = localRealm.objects(WeightRealm.self)
        try! localRealm.write {
            localRealm.delete(alls)
        }
    }
    
    static func deleteAllTodo2() {
        
        let localRealm = try! Realm()
        let alls = localRealm.objects(ToDoListRealm.self)
        try! localRealm.write {
            localRealm.delete(alls)
        }
    }
}
extension ProfileViewController: TodoAdd {
    func addTodo() {
        todo = RealmManager.searchCurrentTodo()
//        print(todo?.content)
        profileTableView.reloadData()
    }
}

extension ProfileViewController: DeleteTodo {
    func didDelete() {
        todo = RealmManager.searchCurrentTodo()
//        print(todo?.content)
        profileTableView.reloadData()
    }
}
