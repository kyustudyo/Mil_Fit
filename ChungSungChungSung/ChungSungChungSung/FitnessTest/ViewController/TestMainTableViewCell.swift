//
//  TestMainTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/07.
//

import UIKit

class TestMainTableViewCell: UITableViewCell {
    
    
    static let identifier = "TestMainTableViewCell"
    @IBOutlet weak var fitnessImageView: UIView!
    @IBOutlet weak var fitnessTitleLabel: UILabel!
    @IBOutlet weak var fitnessRecordDateLabel: UILabel!
    @IBOutlet weak var fitnessRecordLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        drawCellUI()
    }

    func drawCellUI() {
        fitnessTitleLabel.textColor = UIColor.red
        fitnessRecordDateLabel.textColor = UIColor.systemGray
        fitnessImageView.layer.cornerRadius = 20
    }
}
