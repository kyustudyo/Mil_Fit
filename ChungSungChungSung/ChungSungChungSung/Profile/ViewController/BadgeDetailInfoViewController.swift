//
//  BadgeDetailInfoViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/14.
//

import UIKit

class BadgeDetailInfoViewController: UIViewController {
    var badge: BadgeModel?
    
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
            badgeImageView.image = UIImage(named: badgeImage)
        }
        badgeDateLabel.text = badge?.date
        badgeTitleLabel.text = badge?.title
        badgeDescriptionLabel.text = badge?.description
    }
}
