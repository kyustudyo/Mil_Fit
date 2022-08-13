//
//  GoalsTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/12.
//

import UIKit

class GoalsTableViewCell: UITableViewCell {
    var goalsDetailViewDelegate: GoalsDetailViewDelegate?
    
    @IBOutlet weak var cellRectangle: UIView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalSavedDateLabel: UILabel!

    @IBAction func didTapGoalsMoreAction(_ sender: UIButton) {
        goalsDetailViewDelegate?.didTapGoalsMoreButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellRectangle.layer.cornerRadius = 20
        cellRectangle.layer.shadowColor = UIColor.systemGray6.cgColor
        cellRectangle.layer.shadowRadius = 20
        cellRectangle.layer.shadowOpacity = 1
        moreButton.tintColor = CustomColor.editGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
