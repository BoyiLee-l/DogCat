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
//        if Status.shared.jsonData != nil || Status.shared.remoteStarted{
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            let switchVC = SwitchVC()
//            if let ovc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController(){
//                switchVC.shellVC = ovc // the first ViewController
//            }
//            self.window?.rootViewController = switchVC
//            self.window?.makeKeyAndVisible()
//        }
//        UNUserNotificationCenter.current().requestAuthorization(options:
//            [.alert,.sound,.badge, .carPlay], completionHandler: { (granted, error) in
//                if granted {
//                    print("允許")
//                } else {
//                    print("不允許")
//                }
//        })
//        UNUserNotificationCenter.current().delegate = self
        let navigationBarColor =  UINavigationBar.appearance()
        navigationBarColor.barTintColor = .lightGreen
        navigationBarColor.tintColor = .black
        navigationBarColor.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
       
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
//        guard let fun = FunVCSingleton else{
//            return
//        }
//        fun.stopBackGroundUrlCheck()
//        fun.stopProgFetch()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
//        if let lastPresentUrl = MainWebView?.url{
//            PresentingURL = lastPresentUrl
//        }
//        AppDuringUsage = false
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
//        AppDuringUsage = true
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
//        application.applicationIconBadgeNumber = 0
//        if DidReceiveMemoryWarningBackground && PresentingURL != nil{
//            MainWebView?.load(URLRequest(url: PresentingURL!))
//            print("Trig WebView reload due to MemoryWarning")
//            DidReceiveMemoryWarningBackground = false
//        }
//        guard let fun = FunVCSingleton else{
//            return
//        }
//        fun.startBackgroundUrlCheck()
//        fun.startProgFetch()
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
//        print("didReciveMemoryWarning, AppDuringUsage = ",AppDuringUsage)
//        if !AppDuringUsage{DidReceiveMemoryWarningBackground = true}
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
}

