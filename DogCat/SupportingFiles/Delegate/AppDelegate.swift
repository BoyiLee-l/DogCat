//
//  AppDelegate.swift
//  mao_pen_template
//
//  Created by user on 2019/10/16.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationBarColor =  UINavigationBar.appearance()
        navigationBarColor.barTintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 0.5)
        navigationBarColor.tintColor = .black
        navigationBarColor.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {

    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {

    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {

    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {

    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {

    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
}

