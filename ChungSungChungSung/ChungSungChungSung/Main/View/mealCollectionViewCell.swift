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
    
    fileprivate func setupUI() {
        self.layer.cornerRadius = 16
//        contentView.layer.cornerRadius = 16
//        self.layer.backgroundColor = CustomColor.blue?.cgColor
//        self.contentView.backgroundColor = .clear
//        contentView.backgroundColor = .white
//        self.contentView.layer.cornerRadius = 16
//        var labels: [UILabel] = []
        
//        for 반찬 in 반찬들 {
//            let label = UILabel()
//            label.font = UIFont.systemFont(ofSize: Constants.middleText)
//            label.text = 반찬
//            labels.append(label)
//        }
        
//        let 반찬들 = UIStackView(arrangedSubviews: labels)
//        반찬들.alignment = .center
//        반찬들.axis = .vertical
//        반찬들.spacing = 1
        
        let mealVstack = UIStackView(arrangedSubviews: [label1, label2, label3,label4,label5, label6,label7])
//        [label1, label2, label3,label4,label5, label6,label7].forEach { label in
//            label.anchor(left: mealVstack.leftAnchor, right: mealVstack.rightAnchor, paddingLeft: 4, paddingRight: 4)
//        }
//        mealVstack.backgroundColor = .blue
//        mealVstack.backgroundColor = .clear
        mealVstack.axis = .vertical
//        mealVstack.spacing = 3
        contentView.addSubview(mealVstack)
//        self.contentView.backgroundColor = .red
//        self.contentView.layer.cornerRadius = 16
        mealVstack.alignment = .center
        let vstack = UIStackView(arrangedSubviews: [mealLabel, mealVstack])
        
        vstack.axis = .vertical
        vstack.spacing = 12
        vstack.alignment = .center
        addSubview(vstack)
        
//        mealVstack.anchor(left: vstack.leftAnchor, right: vstack.rightAnchor, paddingLeft: 4, paddingRight: 4)
//        vstack.centerX(inView: contentView)
//        vstack.centerY(inView: contentView)
//        contentView.backgroundColor = .gray
//        vstack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
//        vstack.centerY(inView: contentView)
        vstack.anchor(top: contentView.topAnchor, paddingTop: 0)
//        vstack.layer.cornerRadius = 16
//        vstack.backgroundColor = .green
        mealLabel.anchor(top: vstack.topAnchor, paddingTop: 18)
//        mealVstack.anchor(top: mealLabel.bottomAnchor, paddingTop: 12)
//        vstack.backgroundColor = .red
//        vstack.centerX(inView: contentView)
//        mealLabel.anchor(top: vstack.topAnchor, paddingTop: 2)
        vstack.anchor(left: self.leftAnchor, right: self.rightAnchor, paddingLeft: 12, paddingRight: 12)
//        contentView.backgroundColor = .brown
    }
}
