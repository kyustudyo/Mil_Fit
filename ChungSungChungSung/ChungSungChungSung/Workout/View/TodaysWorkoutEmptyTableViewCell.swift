//
//  TodaysWorkoutEmptyTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/18.
//

import UIKit

class TodaysWorkoutEmptyTableViewCell: UITableViewCell {
    @IBOutlet weak var emptyMessageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = CustomColor.bgGray
        emptyMessageLabel.text = "오늘 한 운동이 없습니다."
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
