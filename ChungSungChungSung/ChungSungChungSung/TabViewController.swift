//
//  TabViewController.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/06.
//

//import Foundation
import UIKit
//scenedelegate

class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabItems()
    }
    
    fileprivate func setTabItems() {
        let mainViewController = UINavigationController.init(rootViewController: MainViewController())
       
        self.viewControllers = [mainViewController]
        
        let myBoardTabBarItem = UITabBarItem(title: "My Board", image: UIImage(systemName: "keyboard"), tag: 0)
        
        mainViewController.tabBarItem = myBoardTabBarItem
    }
    
}
