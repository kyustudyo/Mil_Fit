//
//  GoalsTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/12.
//

import UIKit

class GoalsTableViewCell: UITableViewCell {
    var goal = "턱걸이 30개 하기"
    var goalSavedDate = "2022.5.11"
    
    @IBOutlet weak var cellRectangle: UIView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalSavedDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellRectangle.layer.cornerRadius = 12
        cellRectangle.layer.shadowColor = UIColor.systemGray6.cgColor
        cellRectangle.layer.shadowRadius = 20
        cellRectangle.layer.shadowOpacity = 1
        moreButton.tintColor = CustomColor.editGray
        
        goalLabel.text = goal
        goalSavedDateLabel.text = goalSavedDate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
