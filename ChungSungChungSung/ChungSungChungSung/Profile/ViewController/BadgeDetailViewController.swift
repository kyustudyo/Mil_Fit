//
//  BadgeDetailViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/14.
//

import UIKit

class BadgeDetailViewController: UIViewController/*, UIViewControllerTransitioningDelegate*/ {
    private var badgeList = BadgeData().list
    private var numberOfBadgeEarned: Int = 0
    var badgeNames: [String] = [] {
        didSet {
            var indexes: [Int] = []
            for (i,badge) in badgeList.enumerated() {
                if badgeNames.contains(badge.title) {
                    indexes.append(i)
                }
            }
            lightImageIndexes = indexes
        }
    }

    private var lightImageIndexes: [Int] = [] {
        willSet {
            badgeDetailCollectionView?.reloadData()
        }
    }

    @IBOutlet weak var numberOfBadgeLabel: UILabel!
    @IBOutlet weak var badgeDetailCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let badges = RealmManager.searchBadges() {
            badgeNames = badges.map { $0.title }
        }
        setNumberOfBadgeEarned()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = CustomColor.bgGray
        self.navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        self.navigationItem.title = "획득한 뱃지"
        navigationItem.largeTitleDisplayMode = .never
        badgeDetailCollectionView.backgroundColor = .clear
        
        let badgeCollectionViewCellNib = UINib(nibName: "BadgeCollectionViewCell", bundle: nil)
        badgeDetailCollectionView.register(badgeCollectionViewCellNib, forCellWithReuseIdentifier: "badgeCollectionViewCell")
        setNumberOfBadgeEarned()
    }
    
    private func setNumberOfBadgeEarned() {

        numberOfBadgeEarned = badgeNames.count
        numberOfBadgeLabel.text = "\(numberOfBadgeEarned) / 15"
    }
 
}

extension BadgeDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        let viewWidth = self.view.bounds.width
        let spacing = (8 / 390) * viewWidth
        let inset = (16 / 390) * viewWidth
        
        let width = (viewWidth - (inset * 2) - (spacing * 2)) / 3
        let height = width
        
//        flow.minimumInteritemSpacing = spacing
        flow.minimumLineSpacing = spacing
        flow.sectionInset.left = inset
        flow.sectionInset.right = inset
        
        return CGSize(width: width, height: height)
    }
    
    
}

extension BadgeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badgeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "badgeCollectionViewCell", for: indexPath) as? BadgeCollectionViewCell else { return UICollectionViewCell() }
        
        //earnedBadges = 2
        if lightImageIndexes.contains(indexPath.row) {
            cell.badgeImageView.image = UIImage(named: badgeList[indexPath.row].image)
        } else {
            
            cell.badgeImageView.image = UIImage(named: badgeList[indexPath.row].image)?.tonal
        }
        
        cell.badgeNameLabel.text = badgeList[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let badgeDetailInfoView = UIStoryboard(name: "BadgeDetailInfo", bundle: .main).instantiateViewController(withIdentifier: "BadgeDetailInfoViewController") as? BadgeDetailInfoViewController else { return }
        
        badgeDetailInfoView.badge = badgeList[indexPath.row]
        
        if lightImageIndexes.contains(indexPath.row) {
            badgeDetailInfoView.isTonal = false
        } else {
            badgeDetailInfoView.isTonal = true
        }
        
        badgeDetailInfoView.modalPresentationStyle = .pageSheet
//        badgeDetailInfoView.transitioningDelegate = self
        
        if let sheet = badgeDetailInfoView.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 20
            sheet.prefersGrabberVisible = true
        }
        

        
        present(badgeDetailInfoView, animated: true, completion: nil)
    }
}
