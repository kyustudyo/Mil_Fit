//
//  BodyInfoTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/12.
//

import UIKit

class BodyInfoTableViewCell: UITableViewCell {
    var age = "제 0000부대"
    var heightAndWeight = "180cm / 80kg"
    
    @IBOutlet weak var cellRectangle: UIView!
    @IBOutlet weak var editBodyInfoButton: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightAndWeightLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellRectangle.layer.cornerRadius = 8
        editBodyInfoButton.tintColor = CustomColor.editGray
        
        ageLabel.text = age
        heightAndWeightLabel.text = heightAndWeight
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
