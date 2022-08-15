//
//  BadgeCollectionViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/13.
//

import UIKit

class BadgeCollectionViewCell: UICollectionViewCell {
//    var badgeImage: String?
//    var badgeName: String?
    
    @IBOutlet weak var badgeCellRectangle: UIView!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var badgeNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        badgeCellRectangle.layer.cornerRadius = 20
        badgeCellRectangle.layer.shadowColor = UIColor.systemGray6.cgColor
        badgeCellRectangle.layer.shadowRadius = 20
        badgeCellRectangle.layer.shadowOpacity = 1
        
//        if let badgeImage = badgeImage {
//            badgeImageView.image = UIImage(named: badgeImage)
//        }
//        badgeNameLabel.text = badgeName
    }
}
