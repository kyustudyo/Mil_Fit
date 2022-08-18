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
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    fileprivate func setTabItems() {
        let mainViewController = UINavigationController.init(rootViewController: MainViewController())
        
        let workoutStoryboard = UIStoryboard(name: "Workout", bundle: Bundle.main)
        let tempWorkoutViewController = workoutStoryboard.instantiateViewController(identifier: "WorkoutViewController")
        let workoutViewController = UINavigationController.init(rootViewController: tempWorkoutViewController)
        
        let firnessStoryboard = UIStoryboard(name: "TestStoryboard", bundle: Bundle.main)
        let tempFitnessViewController = firnessStoryboard.instantiateViewController(identifier: "TestMainViewController")
        let fitnessViewController = UINavigationController.init(rootViewController: tempFitnessViewController)
        let profileStroyboard = UIStoryboard(name: "Profile", bundle: Bundle.main)
        let tempProfileViewController = profileStroyboard.instantiateViewController(identifier: "ProfileViewController")
        let profileViewController = UINavigationController.init(rootViewController: tempProfileViewController)
        
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
