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
    @IBOutlet weak var fitnessImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        drawCellUI()
    }

    private func drawCellUI() {
        fitnessRecordDateLabel.textColor = UIColor.systemGray2
        fitnessImageView.layer.cornerRadius = 12
    }
}
