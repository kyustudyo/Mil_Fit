//
//  mealCollectionViewCell.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/06.
//

import UIKit

class mealCollectionViewCell: UICollectionViewCell {
    static let cellID = "mealCollectionViewCellID"
    
    let mealLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.bigText - 1, weight: .bold)
        label.text = "조식"
        return label
    }()
    
    var 반찬들: [String] = ["두부된장국", "가자미야끼구이", "시금치프라", "콩나물무침", "우유"]
    
    let calLabel: UILabel = {
        let label = UILabel()
        label.text = "1500kcal"
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

        var labels: [UILabel] = []
        
        for 반찬 in 반찬들 {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: Constants.middleText)
            label.text = 반찬
            labels.append(label)
        }
        
        let 반찬들 = UIStackView(arrangedSubviews: labels)
        반찬들.alignment = .center
        반찬들.axis = .vertical
        반찬들.spacing = 1
        
        let vstack = UIStackView(arrangedSubviews: [mealLabel, 반찬들, calLabel])
        vstack.axis = .vertical
        vstack.spacing = 12
        vstack.alignment = .center
        addSubview(vstack)
        
//        vstack.centerX(inView: contentView)
//        vstack.centerY(inView: contentView)
//        contentView.backgroundColor = .gray
//        vstack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
//        vstack.centerY(inView: contentView)
        vstack.anchor(top: self.topAnchor, bottom: self.bottomAnchor, paddingTop: 15, paddingBottom: 19)
        vstack.centerX(inView: contentView)
//        contentView.backgroundColor = .brown
    }
}
