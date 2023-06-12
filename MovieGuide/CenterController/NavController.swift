//
//  NavController.swift
//  MovieGuide
//
//  Created by Dev on 8/4/2566 BE.
//

import UIKit

class NavController: UINavigationController{
    
    override func viewDidLoad() {
        setAppearance()
    }
    
    private func setAppearance(){
        
        //bg Color Nav
        UINavigationBar.appearance().barTintColor = UIColor.white
        //text color
        UINavigationBar.appearance().tintColor = UIColor.systemBlue
        
        //title page font
        let font = UIFont.systemFont(ofSize: 18, weight: .bold)
        let fontAttributes = [NSAttributedString.Key.font: font]
        UINavigationBar.appearance().titleTextAttributes = fontAttributes
        
        //set backNav no title
        self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        
        self.delegate = self
        if #available(iOS 14.0, *) {
            navigationItem.backButtonDisplayMode = .minimal
        }
    }
}

extension NavController: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        switch viewController{
        case is MovieVC, is TVShowVC:
            tabBarController?.tabBar.isHidden = false
            viewController.navigationController?.isNavigationBarHidden = false
            break
        default:
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        switch viewController{
        case is MovieVC, is TVShowVC:
            tabBarController?.tabBar.isHidden = false
            break
        default:
            tabBarController?.tabBar.isHidden = true
        }
    }
}
