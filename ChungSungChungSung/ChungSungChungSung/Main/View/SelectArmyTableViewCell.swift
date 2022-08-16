//
//  SelectArmyTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/14.
//

import UIKit

class SelectArmyTableViewCell: UITableViewCell {
    static let cellID = "SelectArmyTableViewCellID"
    
    let armyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(armyLabel)
        armyLabel.centerY(inView: contentView)
        armyLabel.anchor(left: contentView.leftAnchor, paddingLeft: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
