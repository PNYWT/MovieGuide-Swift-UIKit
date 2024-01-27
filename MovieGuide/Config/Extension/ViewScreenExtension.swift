//
//  AppdelegateExtension.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation
import UIKit

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
}

extension UIViewController{

    func getSaftArea() -> UIEdgeInsets {
        return self.view.safeAreaInsets
    }
    
    func getNavigationBarHeight() -> CGFloat {
        if let navigationController = self.navigationController {
            return navigationController.navigationBar.frame.height
        }
        return 44
    }
    
    func getTabbarBarHeight() -> CGFloat {
        if let navigationController = self.navigationController {
            return navigationController.tabBarController?.tabBar.frame.height ?? 0
        }
        return 44
    }


    func getStatusBarHeight() -> CGFloat {
        let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
        return windowScene?.statusBarManager?.statusBarFrame.height ?? 44
    }
}
