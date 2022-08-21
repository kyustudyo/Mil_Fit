//
//  AppDelegate.swift
//  ChungSungChungSung
//
//  Created by Hankyu Lee on 2022/08/03.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        UITabBar.appearance().tintColor = CustomColor.mainPurple
        sleep(1)
        
        return true
    }
}
