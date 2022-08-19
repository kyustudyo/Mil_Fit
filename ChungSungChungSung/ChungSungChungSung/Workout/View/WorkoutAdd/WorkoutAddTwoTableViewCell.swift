//
//  WorkoutAddTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/06.
//

import UIKit

class WorkoutAddTwoTableViewCell: UITableViewCell {
    var firstInputText: String?
    var secondInputText: String?
    
    @IBOutlet weak var cellRectangle: UIView!
    @IBOutlet weak var setNumberView: UILabel!
    @IBOutlet weak var firstInputType: UILabel!
    @IBOutlet weak var firstInputField: UITextField!
    @IBOutlet weak var secondInputType: UILabel!
    @IBOutlet weak var secondInputField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellRectangle.layer.cornerRadius = 12
        cellRectangle.layer.shadowColor = UIColor.systemGray5.cgColor
        cellRectangle.layer.shadowRadius = 20
        cellRectangle.layer.shadowOpacity = 1
        
        setNumberView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
