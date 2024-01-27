//
//  ConfigGeneral.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation
import UIKit

class ConfigGeneral{
    static func initWindows(isGoMain:Bool) {
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        
        guard let winScene = sceneDelegate.window?.windowScene else { return }
        if isGoMain {
            DispatchQueue.main.async {
                let viewController:TabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as! TabBarController
                sceneDelegate.window = UIWindow(windowScene: winScene)
                sceneDelegate.window?.rootViewController = viewController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }else{
            DispatchQueue.main.async {
                let viewController:LunachScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LunachScreenVC") as! LunachScreenVC
                sceneDelegate.window = UIWindow(windowScene: winScene)
                sceneDelegate.window?.rootViewController = viewController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}
