//
//  AppDelegate.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import UIKit
import GoogleMobileAds

import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GADMobileAds.sharedInstance().start()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()
        
        
        return true
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

extension AppDelegate{
    static func shareAppDelegate() -> AppDelegate {
        var appDelegate: AppDelegate?
        DispatchQueue.main.async {
            appDelegate = UIApplication.shared.delegate as? AppDelegate
        }
        return appDelegate ?? UIApplication.shared.delegate as! AppDelegate
    }
    
    
    static func shareViewController(base: UIViewController? = UIApplication.shared.connectedScenes
                                            .compactMap { $0 as? UIWindowScene }
                                            .flatMap { $0.windows }
                                            .filter { $0.isKeyWindow }
                                            .first?
                                            .rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return shareViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return shareViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return shareViewController(base: presented)
        }

        return base
    }
    
    func goMain(){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        guard let winScene = sceneDelegate.window?.windowScene else { return }
        if UserDefaults.standard.bool(forKey: KeysUSDF.saveLogin) == true{
            window = UIWindow(windowScene: winScene)
            window?.rootViewController = TabBarController()
            window?.makeKeyAndVisible()
        }else{
            let nav:NavController = NavController.init(rootViewController: LoginVC())
            window = UIWindow(windowScene: winScene)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
    }
}

extension AppDelegate:MessagingDelegate, UNUserNotificationCenterDelegate{
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("userNotificationCenter -> willPresent")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("userNotificationCenter -> didReceive")
    }
}
