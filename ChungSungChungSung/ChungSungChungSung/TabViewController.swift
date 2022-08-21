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
        
        let myBoardTabBarItem = UITabBarItem(title: "요약", image: UIImage(systemName: "doc.text.image"), tag: 0)
        let workoutTabBarItem = UITabBarItem(title: "운동", image: UIImage(systemName: "figure.walk"), tag: 1)
        let fitnessTabBarItem = UITabBarItem(title: "체력검정", image: UIImage(systemName: "flag.filled.and.flag.crossed"), tag: 2)
        let profileTabBarItem = UITabBarItem(title: "프로필", image: UIImage(systemName: "person.fill"), tag: 3)
        
        mainViewController.tabBarItem = myBoardTabBarItem
        workoutViewController.tabBarItem = workoutTabBarItem
        fitnessViewController.tabBarItem = fitnessTabBarItem
        profileViewController.tabBarItem = profileTabBarItem
        
    }
    
}
