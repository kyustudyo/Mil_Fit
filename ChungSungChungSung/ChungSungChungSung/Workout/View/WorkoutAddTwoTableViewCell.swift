//
//  WorkoutAddTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/06.
//

import UIKit

class WorkoutAddTwoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellRectangle: UIView!
    @IBOutlet weak var setNumberView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellRectangle.layer.cornerRadius = 8
        setNumberView.font = UIFont.systemFont(ofSize: 14, weight: .regular)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
