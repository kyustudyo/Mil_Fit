//
//  WorkoutAddPlusTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/06.
//

import UIKit

class WorkoutAddPlusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellRectangle: UIView!
    @IBOutlet weak var plusView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellRectangle.layer.cornerRadius = 12
        cellRectangle.layer.shadowColor = UIColor.systemGray5.cgColor
        cellRectangle.layer.shadowRadius = 20
        cellRectangle.layer.shadowOpacity = 1
        
        plusView.tintColor = CustomColor.mainPurple
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
