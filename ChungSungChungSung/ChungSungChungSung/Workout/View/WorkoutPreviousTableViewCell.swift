//
//  WorkoutPreviousTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/12.
//

import UIKit
import SwiftUI
//달력중앙 한줄
class WorkoutPreviousTableViewCell: UITableViewCell {

    static let cellID = "WorkoutPreviousTableViewCellID"
    
    var workoutNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.middleText, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    fileprivate func setupUI() {
       
//        contentView.addSubview(workoutNameLabel)
//        workoutNameLabel.anchor(left: contentView.leftAnchor, paddingLeft: 20)
//        workoutNameLabel.centerY(inView: self)

        let rightShapeImageView = UIImageView()
        contentView.addSubview(rightShapeImageView)
        rightShapeImageView.image = UIImage(systemName: "chevron.right")
        rightShapeImageView.tintColor = .systemGray2
        
        let stackView = UIStackView(arrangedSubviews: [workoutNameLabel, rightShapeImageView])
        contentView.addSubview(stackView)
        rightShapeImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        stackView.centerY(inView: self)
        stackView.anchor(left: contentView.leftAnchor, right: contentView.rightAnchor, paddingLeft: 20, paddingRight: 10)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
