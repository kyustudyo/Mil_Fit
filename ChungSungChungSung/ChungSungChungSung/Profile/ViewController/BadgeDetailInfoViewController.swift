//
//  BadgeDetailInfoViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/14.
//

import UIKit

class BadgeDetailInfoViewController: UIViewController {
    var badge: BadgeModel?
    
    var isTonal: Bool = true
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var badgeDateLabel: UILabel!
    @IBOutlet weak var badgeTitleLabel: UILabel!
    @IBOutlet weak var badgeDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        putDataToView()
        
    }
    
    private func putDataToView() {
        if let badgeImage = badge?.image {
            let image = isTonal ? UIImage(named: badgeImage)?.tonal : UIImage(named: badgeImage)
            badgeImageView.image = image
            
        }
//        badgeDateLabel.text = badge?.date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        if let badges = RealmManager.searchBadges() {
            if let index = badges.map { $0.title }.firstIndex(of: badge?.title) {
                badgeDateLabel.text = dateFormatter.string(from: badges[index].date)
            } else {
                badgeDateLabel.text = "-"
            }
        }
        badgeTitleLabel.text = badge?.title
        
        badgeDescriptionLabel.text = isTonal ? "???" : badge?.description 
    }
    
}

