//
//  WorkoutViewController.swift
//  ChungSungChungSung
//
//  Created by Eunbee Kang on 2022/08/05.
//

import UIKit

class WorkoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigationTitle()
    }
    
    private func configNavigationTitle() {
        let viewWidth = self.view.bounds.width - 140
        let workoutViewTitle = UILabel(frame: CGRect(x: 25, y: 0, width: viewWidth, height: 20))
        workoutViewTitle.textAlignment = .left
        workoutViewTitle.font = UIFont.boldSystemFont(ofSize: 28)
        workoutViewTitle.text = "운동"
        
        self.navigationItem.titleView = workoutViewTitle
    }

}
