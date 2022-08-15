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
        
        let workoutStoryboard = UIStoryboard(name: "Workout", bundle: Bundle.main)
        let workoutViewController = workoutStoryboard.instantiateViewController(identifier: "WorkoutViewController")
        let firnessStoryboard = UIStoryboard(name: "TestStoryboard", bundle: Bundle.main)
        let fitnessViewController = firnessStoryboard.instantiateViewController(identifier: "TestMainViewController")
        let profileStroyboard = UIStoryboard(name: "Profile", bundle: Bundle.main)
        let profileViewController = profileStroyboard.instantiateViewController(identifier: "ProfileViewController")
        self.viewControllers = [mainViewController, workoutViewController, fitnessViewController, profileViewController]
        
        let myBoardTabBarItem = UITabBarItem(title: "My Board", image: UIImage(systemName: "keyboard"), tag: 0)
        let workoutTabBarItem = UITabBarItem(title: "My Board", image: UIImage(systemName: "keyboard"), tag: 1)
        let fitnessTabBarItem = UITabBarItem(title: "My Board", image: UIImage(systemName: "keyboard"), tag: 2)
        let profileTabBarItem = UITabBarItem(title: "My Board", image: UIImage(systemName: "keyboard"), tag: 3)
        
        mainViewController.tabBarItem = myBoardTabBarItem
        workoutViewController.tabBarItem = workoutTabBarItem
        fitnessViewController.tabBarItem = fitnessTabBarItem
        profileViewController.tabBarItem = profileTabBarItem
        
    }
    
}
