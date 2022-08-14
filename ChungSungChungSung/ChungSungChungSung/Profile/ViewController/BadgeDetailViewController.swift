//
//  BadgeDetailViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/14.
//

import UIKit

class BadgeDetailViewController: UIViewController {
    private var badgeList = BadgeData().list
    
    @IBOutlet weak var numberOfBadgeLabel: UILabel!
    @IBOutlet weak var badgeDetailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = CustomColor.bgGray
        self.navigationController?.navigationBar.tintColor = CustomColor.mainPurple
        self.navigationItem.title = "획득한 뱃지"
        badgeDetailCollectionView.backgroundColor = .clear
        
        let badgeCollectionViewCellNib = UINib(nibName: "BadgeCollectionViewCell", bundle: nil)
        badgeDetailCollectionView.register(badgeCollectionViewCellNib, forCellWithReuseIdentifier: "badgeCollectionViewCell")
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
        
        flow.minimumInteritemSpacing = spacing
        flow.minimumLineSpacing = spacing
        
        return CGSize(width: width, height: height)
    }
}

extension BadgeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        badgeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "badgeCollectionViewCell", for: indexPath) as? BadgeCollectionViewCell else { return UICollectionViewCell() }
        
        cell.badgeImageView.image = UIImage(named: badgeList[indexPath.row].image)
        cell.badgeNameLabel.text = badgeList[indexPath.row].title
        
        return cell
    }
}
