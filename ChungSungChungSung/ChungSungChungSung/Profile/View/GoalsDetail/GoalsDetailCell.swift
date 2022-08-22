//
//  GoalsDetailCell.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/14.
//

import UIKit

class GoalsDetailCell: UITableViewCell {
    @IBOutlet weak var cellRectangle: UIView!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var goalSavedDateLabel: UILabel!
    @IBOutlet weak var achievedButton: UIButton!
    var goalID: Int?
    weak var delegate: TodoDone?
    
    @IBAction func doneTodo(_ sender: UIButton) {
        delegate?.changeTodoDone(id: goalID)
    }
   
}
protocol TodoDone: AnyObject {
    func changeTodoDone(id: Int?)
}
