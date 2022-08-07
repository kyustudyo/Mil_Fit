//
//  purposeCollectionVIewCell.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/06.
//

import UIKit

class PurposeCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "purposeCollectionViewCellID"
    
//    override func layoutSubviews() {
//        setupUI()
//    }
    
    let purposeLabel: UILabel = {
        let label = UILabel()
        label.text = "턱걸이 3000개 하기"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.5.12"
        return label
    }()
    
    let didOrNot: UIImageView = {
        let imageView = UIImageView()
        let largeBoldDoc = UIImage(systemName: "hand.thumbsup.circle.fill")
        imageView.image = largeBoldDoc
        imageView.setHeight(height: 40)
        imageView.setWidth(width: 40)
        return imageView
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
        let hstack = UIStackView(arrangedSubviews: [dateLabel, didOrNot])
        let vstack = UIStackView(arrangedSubviews: [purposeLabel, hstack])
        vstack.axis = .vertical
        contentView.addSubview(vstack)
        vstack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
}
