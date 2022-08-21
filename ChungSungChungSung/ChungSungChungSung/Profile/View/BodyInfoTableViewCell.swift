//
//  BodyInfoTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/12.
//

import UIKit
import RealmSwift

class BodyInfoTableViewCell: UITableViewCell {
//    var age = "23"
//    var heightAndWeight = "180cm / 80kg"
    
    @IBOutlet weak var cellRectangle: UIView!
    @IBOutlet weak var editBodyInfoButton: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightAndWeightLabel: UILabel!
    @IBAction func editBody(_ sender: UIButton) {
        delegate?.goBodyInfoProfileVC()
    }
    weak var delegate: EditBodyViewRelated?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellRectangle.layer.cornerRadius = 12
        cellRectangle.layer.shadowColor = UIColor.systemGray6.cgColor
        cellRectangle.layer.shadowRadius = 20
        cellRectangle.layer.shadowOpacity = 1
        editBodyInfoButton.tintColor = CustomColor.editGray
        
//        ageLabel.text = "\(UserDefaultManager.loadAge())"
//        let localRealm = try! Realm()
//        let weight = localRealm.objects(WeightRealm.self).sorted(byKeyPath: "dateSorting", ascending: false).first?.weight
//        heightAndWeightLabel.text = "\(UserDefaultManager.loadHeight())/\(weight)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol EditBodyViewRelated: AnyObject {
    func goBodyInfoProfileVC()
}
