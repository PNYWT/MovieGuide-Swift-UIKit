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
        
        UserDefaults.standard.setValue("©Copyright CallmeOni, 2023", forKey: KeysUSDF.CreateBy)
        DispatchQueue.main.async {
            BannerMobileAds.shared.requestIDFA()
            BannerMobileAds.shared.startBanner()
        }
    }
    
    private func setAppearance(){
        
        //bg Color Nav
        UINavigationBar.appearance().barTintColor = UIColor.white
        //text color
        UINavigationBar.appearance().tintColor = UIColor.customRed //UIColor.systemBlue
        
        //title page font
        let font = UIFont.systemFont(ofSize: 18, weight: .bold)
        let fontAttributes = [NSAttributedString.Key.font: font]
        UINavigationBar.appearance().titleTextAttributes = fontAttributes
        
        //set backNav no title
        self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        
        self.delegate = self
        self.navigationItem.backButtonDisplayMode = .minimal
        
        //config tabbar background
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .customRed
        tabBarController?.tabBar.standardAppearance = appearance
        tabBarController?.tabBar.tintColor = .white
        tabBarController?.tabBar.scrollEdgeAppearance = tabBarController?.tabBar.standardAppearance
    }
}

extension NavController: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        switch viewController{
        case is MainMovieVC, is TVShowVC:
            tabBarController?.tabBar.isHidden = false
            viewController.navigationController?.isNavigationBarHidden = false
            
            if viewController.isKind(of: MainMovieVC.classForCoder()){
                viewController.title = "Movie"
            }else if viewController.isKind(of: TVShowVC.classForCoder()){
                viewController.title = "TV Show"
            }else if viewController.isKind(of: DetailSelectVC.classForCoder()){
                viewController.title = "Detail"
                tabBarController?.tabBar.isHidden = true
            }
            break
        default:
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        switch viewController{
        case is MainMovieVC, is TVShowVC, is DetailSelectVC:
            tabBarController?.tabBar.isHidden = false
            if viewController.isKind(of: MainMovieVC.classForCoder()){
                viewController.title = "Movie"
                
                
                let img = UIImage(systemName: "person.crop.circle")!.withRenderingMode(.alwaysOriginal)
                let loginBtn = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(gotoLoginVC))
                viewController.navigationItem.rightBarButtonItems = [loginBtn]
                
            }else if viewController.isKind(of: TVShowVC.classForCoder()){
                viewController.title = "TV Show"
            }else if viewController.isKind(of: DetailSelectVC.classForCoder()){
                viewController.title = "Detail"
                tabBarController?.tabBar.isHidden = true
            }
            break
        default:
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    @objc func gotoLoginVC(){
        let vc = LoginVC()
        AppDelegate.shareViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
