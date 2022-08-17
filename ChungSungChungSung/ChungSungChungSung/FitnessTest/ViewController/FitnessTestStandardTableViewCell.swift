//
//  FitnessTestStandardTableViewCell.swift
//  ChungSungChungSung
//
//  Created by Ayden on 2022/08/10.
//

import UIKit

class FitnessTestStandardTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shadowColor = UIColor.blue.cgColor
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
