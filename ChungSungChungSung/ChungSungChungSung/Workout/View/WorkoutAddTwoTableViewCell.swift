//
//  WorkoutAddTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/06.
//

import UIKit

class WorkoutAddTwoTableViewCell: UITableViewCell {
    var firstInputTypeText = "kg"
    var secondInputTypeText = "회"
    
    @IBOutlet weak var cellRectangle: UIView!
    @IBOutlet weak var setNumberView: UILabel!
    @IBOutlet weak var firstInputType: UILabel!
    @IBOutlet weak var secondInputType: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellRectangle.layer.cornerRadius = 8
        setNumberView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        firstInputType.text = firstInputTypeText
        secondInputType.text = secondInputTypeText

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
