//
//  GetConstantLayout.swift
//  MovieGuide
//
//  Created by CallmeOni on 13/10/2566 BE.
//

import Foundation
import UIKit

//MARK: UIWindow
extension UIWindow {
    func visibleViewController() -> UIViewController? {
        if let rootViewController = self.rootViewController {
            return UIWindow.getVisibleViewController(from: rootViewController)
        }
        return nil
    }

    private static func getVisibleViewController(from vc: UIViewController) -> UIViewController {
        if let navigationController = vc as? UINavigationController {
            return UIWindow.getVisibleViewController(from: navigationController.visibleViewController!)
        } else if let tabBarController = vc as? UITabBarController {
            return UIWindow.getVisibleViewController(from: tabBarController.selectedViewController!)
        } else {
            if let presentedViewController = vc.presentedViewController {
                return UIWindow.getVisibleViewController(from: presentedViewController)
            } else {
                return vc
            }
        }
    }
    
    //MARK: topViewController
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while let presented = top?.presentedViewController {
            top = presented
        }
        return top
    }
}

extension UIViewController{
    //ใช้ใน nav ตั้งชื่อหน้า
    func setViewControllerTitle(_ viewController: UIViewController, title: String?) {
        if let title_name = title{
            viewController.title = title_name
        }else{
            viewController.title = ""
        }
    }
    
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
        if let windowScene = UIApplication.shared.windows.first?.windowScene {
            return windowScene.statusBarManager?.statusBarFrame.height ?? 0
        }
        return 44
    }
}
