//
//  MainViewController.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/06.
//

import UIKit
//TODO: scrollview
// 맨아래 작은것들 uiview로 만들기
class MainViewController: UIViewController {

    var 전역가까움: Float = 0.9
    
    fileprivate let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022년 8월 21일"
        return label
    }()
    
    fileprivate let todayMent: UILabel = {
        let label = UILabel()
        label.text = "오늘도 열심히 운동해요!"
        return label
    }()
    
    fileprivate let endDayBar: UIProgressView = {
        let bar = UIProgressView()
        bar.progressTintColor = UIColor.systemGray
        bar.setHeight(height: 30)
        bar.progressTintColor = .gray
        
        bar.clipsToBounds = true
        bar.layer.cornerRadius = 16
        bar.layer.sublayers![1].cornerRadius = 16// 뒤에 있는 회색 track
        bar.subviews[1].clipsToBounds = true
        return bar
    }()
    
    fileprivate let 전역일: UILabel = {
        let label = UILabel()
        label.text = "전역일"
        return label
    }()
    
    fileprivate let dDay: UILabel = {
        let label = UILabel()
        label.text = "D-212"
        return label
    }()
    
    fileprivate let purposeLabel: UILabel = {
        let label = UILabel()
        label.text = "목표"
        return label
    }()
    
    fileprivate let mealLabel: UILabel = {
        let label = UILabel()
        label.text = "식단"
        return label
    }()
    
    fileprivate let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "더보기"
        return label
    }()
    
    let eatPercent = 70.0
    let workoutPercent = 45.0
    let basicPercent = 40.0
    
    fileprivate lazy var basicRoundedView: UIView = {
        let roundedView = Bar()
        roundedView.progressValue = basicPercent
        roundedView.progressColor = .green
        roundedView.trackColor = .clear
        return roundedView
    }()
    
//    fileprivate lazy var shortBasicRoundedView: UIView = {
//        let roundedView = Bar()
//        roundedView.progressValue = 25.0
//        roundedView.progressColor = .green
//        roundedView.trackColor = .clear
//        return roundedView
//    }()
    
    
    fileprivate let shortBasicRoundedView: UIProgressView = {
        let bar = UIProgressView()
        bar.progressTintColor = UIColor.systemGray
        bar.setHeight(height: 30)
        bar.progressTintColor = .green
        bar.progress = 1
        bar.clipsToBounds = true
        bar.layer.cornerRadius = 16
        bar.layer.sublayers![1].cornerRadius = 16// 뒤에 있는 회색 track
        bar.subviews[1].clipsToBounds = true
        return bar
    }()
    
    fileprivate lazy var workoutRoundedView: UIView = {
        let roundedView = Bar()
        roundedView.progressValue = basicPercent + workoutPercent
        roundedView.progressColor = .blue
        roundedView.trackColor = .clear
        return roundedView
    }()
    
//    fileprivate lazy var shortWorkoutRoundedView: UIView = {
//        let roundedView = Bar()
//        roundedView.progressValue = 25.0
//        roundedView.progressColor = .blue
//        roundedView.trackColor = .clear
//        return roundedView
//    }()
    
    fileprivate let shortWorkoutRoundedView: UIProgressView = {
        let bar = UIProgressView()
        bar.progressTintColor = UIColor.systemGray
        bar.setHeight(height: 30)
        bar.progressTintColor = .green
        bar.progress = 1.0
        bar.clipsToBounds = true
        bar.layer.cornerRadius = 16
        bar.layer.sublayers![1].cornerRadius = 16// 뒤에 있는 회색 track
        bar.subviews[1].clipsToBounds = true
        return bar
    }()
    
    
    fileprivate lazy var eatRoundedView: UIView = {
        let roundedView = Bar()
        roundedView.progressValue = eatPercent
        roundedView.progressColor = .brown
        roundedView.trackColor = .clear
        return roundedView
    }()
    
//    fileprivate lazy var shortEatRoundedView: UIView = {
//        let roundedView = Bar()
//        roundedView.progressValue = 25.0
//        roundedView.progressColor = .brown
//        roundedView.trackColor = .clear
//        return roundedView
//    }()
    
    fileprivate let shortEatRoundedView: UIProgressView = {
        let bar = UIProgressView()
        bar.progressTintColor = UIColor.systemGray
        bar.setHeight(height: 30)
        bar.progressTintColor = .green
        bar.progress = 1.0
        bar.clipsToBounds = true
        bar.layer.cornerRadius = 16
        bar.layer.sublayers![1].cornerRadius = 16// 뒤에 있는 회색 track
        bar.subviews[1].clipsToBounds = true
        return bar
    }()
    
    private enum Constants {
//        static let itemSize = CGSize(width: 100, height: 72)
        static let lineSpacing = 8.0
        static let purposeCellHeight = 105.0
        static let mealCellHeight = 185.0
//        static let minimumInteritemSpacing = 0.0
        static let collectionViewContentInset = UIEdgeInsets(top: 10, left: 6, bottom: 10, right: 6)
      }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        //MARK: (날짜 + 멘트)
        let stack = UIStackView(arrangedSubviews: [dateLabel, todayMent])
        stack.axis = .vertical
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingRight: 16)
        
        //MARK: 전역일 프로그레스
        view.addSubview(endDayBar)
        endDayBar.anchor(top:stack.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor,paddingTop: 32, paddingLeft: 0, paddingRight: 0)
        endDayBar.progress = 전역가까움
        
        view.addSubview(전역일)
        전역일.centerY(inView: endDayBar)
        전역일.anchor(left: endDayBar.leftAnchor, paddingLeft: 8)
        
        view.addSubview(dDay)
        dDay.anchor(bottom: endDayBar.topAnchor, right: view.safeAreaLayoutGuide.leftAnchor,paddingBottom: 8, paddingRight: 전역가까움 > 0.1 ? -CGFloat(전역가까움) * (UIScreen.main.bounds.width - 16) : -60)
        
        //MARK: (목표들)
        let purposeStack = UIStackView(arrangedSubviews: [purposeLabel, purposeCollectionView])
        purposeStack.axis = .vertical
        purposeStack.spacing = 8
        view.addSubview(purposeStack)
        purposeStack.anchor(top: endDayBar.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingRight: 0)
        purposeCollectionView.anchor(left: stack.leftAnchor, right: stack.rightAnchor, paddingLeft: 0, paddingRight: 0)
        purposeCollectionView.setHeight(height: Constants.purposeCellHeight)
        
        //MARK: 운동 달력
        
        //MARK: 식단
        let mealHStack = UIStackView(arrangedSubviews: [mealLabel, moreLabel])
        moreLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let mealStack = UIStackView(arrangedSubviews: [mealHStack, mealCollectionView])
        mealStack.axis = .vertical
        mealStack.spacing = 8
        view.addSubview(mealStack)
        mealStack.anchor(top: purposeStack.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingRight: 0)
        mealCollectionView.anchor(left: stack.leftAnchor, right: stack.rightAnchor, paddingLeft: 0, paddingRight: 0)
        mealCollectionView.setHeight(height: Constants.mealCellHeight)
        
        //MARK: 칼로리
        view.addSubview(eatRoundedView)
        eatRoundedView.anchor(top: mealStack.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingRight: 0, height: 16)
        
        
        view.addSubview(workoutRoundedView)
        workoutRoundedView.anchor(top: eatRoundedView.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingRight: 0, height: 16)
        
        view.addSubview(basicRoundedView)
        basicRoundedView.anchor(top: workoutRoundedView.topAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 16)
        
        let threeRoundedViewStack = UIStackView(arrangedSubviews: [shortBasicRoundedView, shortWorkoutRoundedView, shortEatRoundedView])
//        threeRoundedViewStack.distribution = .equalCentering
//        threeRoundedViewStack.backgroundColor = .cyan

        view.addSubview(threeRoundedViewStack)
        threeRoundedViewStack.distribution = .fillEqually
        
        shortBasicRoundedView.setWidth(width: 30)
        shortWorkoutRoundedView.setWidth(width: 30)
        shortEatRoundedView.setWidth(width: 30)
        
        threeRoundedViewStack.anchor(top: basicRoundedView.bottomAnchor, left: stack.leftAnchor, right: stack.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 16)

        view.backgroundColor = .white
    }
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
            cell.backgroundColor = .systemGray6
            return cell
        case mealCollectionView:
            print("cell mealCollectionView")
            guard let cell = mealCollectionView.dequeueReusableCell(withReuseIdentifier: mealCollectionViewCell.cellID, for: indexPath) as? mealCollectionViewCell else { return UICollectionViewCell() }
            cell.backgroundColor = .systemGray6
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
    // 셀 사이즈 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        print(collectionView)
        switch collectionView {
        case purposeCollectionView:
            let width: CGFloat = (view.bounds.width - (20 * 5))
    //        let height: CGFloat = width + 35
            let height: CGFloat = Constants.purposeCellHeight
            return CGSize(width: width, height: height)
            
        case mealCollectionView:
            let width: CGFloat = (view.bounds.width / 2.5)
    //        let height: CGFloat = width + 35
            let height: CGFloat = Constants.mealCellHeight
            return CGSize(width: width, height: height)
            
        default:
            return CGSize()
        }

        
    }
    
}

//MARK: 식단 collectionView
