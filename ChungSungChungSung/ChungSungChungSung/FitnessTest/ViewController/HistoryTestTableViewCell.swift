//
//  HistoryTestTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/20.
//

import UIKit

class HistoryTestTableViewCell: UITableViewCell {

    @IBOutlet weak var runningTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var runningRecordLabel: UILabel!
    @IBOutlet weak var pushupTitleLabel: UILabel!
    @IBOutlet weak var pushupRecordLabel: UILabel!
    @IBOutlet weak var situpTitleLabel: UILabel!
    @IBOutlet weak var situpRecordLabel: UILabel!
    
    static let identifier = "HistoryTestTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        runningTitleLabel.textColor = CustomColor.red
        runningTitleLabel.text = "3km달리기"
        pushupTitleLabel.textColor = CustomColor.strongPurple
        pushupTitleLabel.text = "팔굽혀펴기"
        situpTitleLabel.textColor = CustomColor.blue
        situpTitleLabel.text = "윗몸일으키기"
        dateLabel.textColor = .systemGray2
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    }

}
