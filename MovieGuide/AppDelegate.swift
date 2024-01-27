//
//  AppDelegate.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import UIKit
import ProgressHUD

import WidgetKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        setupApp()
        
        return true
    }
    
    private func setupApp(){
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
        
        KeyChainManager.storeKey("d86faff0304420d80a4eb8624dd3a665", forKey: ConfigURL.API_KEY)
        KeyChainManager.storeKey("AIzaSyDTmMzB_ClK_A4RbeQeEb70SEzAcp-o9LA", forKey: ConfigURL.YoutubeAPI_KEY)
        ProgressHUD.animationType = .activityIndicator
        ProgressHUD.mediaSize = 25
        ProgressHUD.marginSize = 25
        ProgressHUD.fontStatus = .boldSystemFont(ofSize: 14)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
