//
//  DailyCalendarCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/07.
//

import UIKit

class DailyCalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var dateNumberView: UILabel!
    @IBOutlet weak var dayNameView: UILabel!
    @IBOutlet weak var dayHighlightView: UIView!
    @IBOutlet weak var dateHighlightCircleView: UIView!
 
//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                dayHighlightView.alpha = 1.0
//                dayNameView.textColor = .white
//            } else {
//                dayHighlightView.alpha = 0.0
////                dayNameView.textColor = .black
//            }
//        }
//    }
}
