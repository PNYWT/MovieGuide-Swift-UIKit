//
//  GetConstantLayout.swift
//  MovieGuide
//
//  Created by CallmeOni on 13/10/2566 BE.
//

import Foundation
import UIKit

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
