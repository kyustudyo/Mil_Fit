//
//  WorkoutAddOneTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/06.
//

import UIKit

class WorkoutAddOneTableViewCell: UITableViewCell {
    var inputTypeText = "회"
    
    @IBOutlet weak var cellRectangle: UIView!
    @IBOutlet weak var setNumberView: UILabel!
    @IBOutlet weak var inputType: UILabel!

    @IBOutlet weak var countTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellRectangle.layer.cornerRadius = 8
        setNumberView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        inputType.text = inputTypeText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
