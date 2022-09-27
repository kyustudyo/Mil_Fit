//
//  mealCollectionViewCell.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/06.
//

import UIKit

class mealCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "mealCollectionViewCellID"
    
    override func awakeFromNib() {
        layer.cornerRadius = 16
    }
    
    let mealLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.bigText - 1, weight: .bold)
        label.text = "조식"
        return label
    }()
    
    var mealStringArray: [String] = [] {
        didSet {
            setupUI()
        }
    }

    
    var 반찬들: [String] = ["두부된장국", "가자미야끼구이", "시금치프라", "콩나물무침", "우유"]
    
    var label1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.smallText , weight: .light)
        return label
    }()
    
    var label2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: Constants.smallText , weight: .light)
        return label
    }()
    var label3: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: Constants.smallText , weight: .light)
        return label
    }()
    var label4: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: Constants.smallText , weight: .light)
        return label
    }()
    var label5: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: Constants.smallText , weight: .light)
        return label
    }()
    var label6: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: Constants.smallText , weight: .light)
        return label
    }()
    var label7: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: Constants.smallText , weight: .light)
        return label
    }()
    
    let calLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.smallText - 1)
        label.textColor = .systemGray2
        return label
    }()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    private func setupUI() {
        
        self.layer.cornerRadius = 16
        self.setShadow()
        
        let labels = [label1, label2, label3,label4,label5, label6,label7]
        
        for (i, s) in mealStringArray.enumerated() {
            labels[i].text = s
        }
        let mealVstack = UIStackView(arrangedSubviews: labels)
        
        mealVstack.axis = .vertical
        contentView.addSubview(mealVstack)
        mealVstack.alignment = .center
        let vstack = UIStackView(arrangedSubviews: [mealLabel, mealVstack])
        vstack.axis = .vertical
        vstack.spacing = 12
        vstack.alignment = .center
        addSubview(vstack)
        vstack.anchor(top: contentView.topAnchor, paddingTop: 0)
        mealLabel.anchor(top: vstack.topAnchor, paddingTop: 18)
        vstack.anchor(left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 12, paddingRight: 12)
    }
}
