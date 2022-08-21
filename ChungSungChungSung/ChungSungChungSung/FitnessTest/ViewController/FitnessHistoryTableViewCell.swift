//
//  FitnessHistoryTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/11.
//

import UIKit

class FitnessHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    
    static let identifier = "FitnessHistoryTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.textColor = .systemGray2
    }

}
