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
    private var selectedCell: Int?
    private var weekdays: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    private var dates: [String] = ["8", "9", "10", "11", "12", "13", "14"]
    
    @IBOutlet weak var selectedDateView: UILabel!
    @IBOutlet weak var dailyCalendarView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigationTitle()
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
        var month: Int = 8
        var date: Int = 10
//        var selectedDateText: String = "\(month)월 \(date)일"
        var selectedTodayText: String = "\(month)월 \(date)일, 오늘"
        
        selectedDateView.text = selectedTodayText
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
        
        cell.dateNumberView.text = dates[indexPath.item]
        cell.dayNameView.text = weekdays[indexPath.item]
        cell.dayHighlightView.layer.cornerRadius = 26
        cell.dayHighlightView.backgroundColor = CustomColor.mainPurple
        
        if indexPath.item == selectedCell {
            cell.dayHighlightView.alpha = 1.0
            cell.dayNameView.textColor = .white
        } else {
            cell.dayHighlightView.alpha = 0.0
            cell.dayNameView.textColor = .black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.item
    }
}

extension WorkoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        
        let viewWidth = self.view.bounds.width
        let inset = (17 / 390) * viewWidth
        let spacing = (8 / 390) * viewWidth
        
        let width = (viewWidth - (inset * 2) - (spacing * 5)) / 6
        let height = (86 / 53) * width
        
        flow.minimumInteritemSpacing = spacing
        flow.minimumLineSpacing = spacing
        flow.sectionInset.left = inset
        flow.sectionInset.right = inset
        
        return CGSize(width: width, height: height)
    }
}
