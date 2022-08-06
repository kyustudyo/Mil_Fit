//
//  TestMainViewController.swift
//  ChungSungChungSung
//
//  Created by Somin Park on 2022/08/06.
//

import UIKit

class TestMainViewController: UIViewController {

    @IBOutlet weak var fitnessGraphButton: UIButton!
    
    @IBOutlet weak var graphRoundedRectangleView: UIView!
    @IBOutlet weak var historyFitnessTestLabel: UILabel!
    @IBOutlet weak var lastFitnessTestDateLabel: UILabel!
    @IBOutlet weak var goToHistoryLabel: UILabel!
    
    @IBOutlet weak var runningGraphView: UIView!
    @IBOutlet weak var runningGraphTitleLabel: UILabel!
    @IBOutlet weak var runningGraphRecordLabel: UILabel!
    
    @IBOutlet weak var pushupGraphView: UIView!
    @IBOutlet weak var pushupGraphTitleLabel: UILabel!
    @IBOutlet weak var pushupGraphRecordLabel: UILabel!
    
    @IBOutlet weak var situpGraphView: UIView!
    @IBOutlet weak var situpGraphTitleLabel: UILabel!
    @IBOutlet weak var situpGraphRecordLabel: UILabel!
    
    
    @IBOutlet weak var recordTableViewTitleLabel: UILabel!

    @IBOutlet weak var fitnessMainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

