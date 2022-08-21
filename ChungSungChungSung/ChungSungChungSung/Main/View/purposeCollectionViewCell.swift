//
//  purposeCollectionVIewCell.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/06.
//

import UIKit
import RealmSwift

class PurposeCollectionViewCell: UICollectionViewCell {
    
    static let cellID = "purposeCollectionViewCellID"
    
    weak var delegate: didPurpose?
    
    var todoID: Int = 0
    
    let purposeLabel: UILabel = {
        let label = UILabel()
        label.text = "턱걸이 3000개 하기"
        label.font = UIFont.systemFont(ofSize: Constants.middleText)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.5.12"
        label.font = UIFont.systemFont(ofSize: Constants.middleText - 2)
        return label
    }()
    
    lazy var thumbButton: UIButton = {
        let button = UIButton()
        let boldConfig = UIImage.SymbolConfiguration(pointSize: 38)
        let largeBoldDoc = UIImage(systemName: "hand.thumbsup.circle.fill", withConfiguration: boldConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.addTarget(self, action: #selector(getThumbUp), for: .touchUpInside)
        return button
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

        let vstack = UIStackView(arrangedSubviews: [purposeLabel, dateLabel])
        vstack.axis = .vertical
        vstack.spacing = 24.0
//        purposeLabel.text = todo?.content
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd"
//        print("qweqwe", todo)
//        dateLabel.text = dateFormatter.string(from: todo?.date ?? Date().addingTimeInterval(60*60*9))
//        thumbButton.tintColor = todo?.isDone == false ? .gray : .none
        let hstack = UIStackView(arrangedSubviews: [vstack, thumbButton])
        thumbButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        contentView.addSubview(hstack)
        hstack.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 26.0, paddingLeft: 13.0, paddingBottom: 24.0, paddingRight: 16)
    }
    
    @objc fileprivate func getThumbUp() {
        if thumbButton.tintColor == .gray {
            thumbButton.tintColor = .none
        } else {
            thumbButton.tintColor = .gray
        }
//        thumbButton.tintColor = thumbButton.tintColor == .gray ? .none : .gray
        delegate?.getThumbUp(todoID: todoID)
    }
}

protocol didPurpose: AnyObject {
    func getThumbUp(todoID: Int)
}
