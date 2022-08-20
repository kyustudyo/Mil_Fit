//
//  ArmyInfoTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/12.
//

import UIKit

class ArmyInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellRectangle: UIView!
    @IBOutlet weak var editArmyInfoButton: UIButton!
    @IBOutlet weak var armyCorpsNameLabel: UILabel!
    @IBOutlet weak var dischargeDateLabel: UILabel!
    weak var delegate: EditDischargeViewRelated?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellRectangle.layer.cornerRadius = 12
        cellRectangle.layer.shadowColor = UIColor.systemGray6.cgColor
        cellRectangle.layer.shadowRadius = 20
        cellRectangle.layer.shadowOpacity = 1
        editArmyInfoButton.tintColor = CustomColor.editGray
        
    }
    
    @IBAction func editTexts(_ sender: Any) {
        delegate?.goDischargeDetailVC()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
protocol EditDischargeViewRelated: AnyObject {
    func goDischargeDetailVC()
}
