//
//  NavController.swift
//  MovieGuide
//
//  Created by Dev on 8/4/2566 BE.
//

import UIKit

class KeysUSDF{
    static let CreateBy = "CreateBy"
}

class NavController: UINavigationController{
    
    private lazy var leftBarButton: UIBarButtonItem = {
        let containerView = UIView()
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "popcorn")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        var height = 25.0
        if let imageSize = imageView.image?.size{
            height = 25.0
        }
        imageView.heightAnchor.constraint(equalToConstant: height).isActive = true // width * 1/ratio
        
        let label = UILabel()
        label.text = "Moview Guild"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white

        containerView.addSubview(imageView)
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        let button = UIBarButtonItem(customView: containerView)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        UserDefaults.standard.setValue("©Copyright CallmeOni, 2023", forKey: KeysUSDF.CreateBy)
    }
    
    private func setAppearance(){
        self.delegate = self
        
        self.navigationItem.hidesBackButton = true
        tabBarController?.tabBar.isHidden = true
        
        //Style bar
        navigationBar.isTranslucent = true
        tabBarController?.tabBar.barStyle = .black
        
        
        //bg Color Nav
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        navigationBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationBar.scrollEdgeAppearance = appearance
        }
        
        ///tintColor
        navigationBar.tintColor = .white
        tabBarController?.tabBar.tintColor = .white
        
        //title page font
        let font = UIFont.boldSystemFont(ofSize: 18)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: font
        ]
        navigationBar.titleTextAttributes = titleAttributes
        UIBarButtonItem.appearance().setTitleTextAttributes(titleAttributes, for: .normal)
        
        //set backNav No title
        self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        self.navigationBar.topItem?.backBarButtonItem?.tintColor = .white
    }
}

extension NavController: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        setupViewController(viewController: viewController)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        setupViewController(viewController: viewController)
    }
    
    private func setupViewController(viewController:UIViewController){
        viewController.view.backgroundColor = .black
        switch viewController{
        case is HomeVC:
            viewController.tabBarController?.tabBar.isHidden = false
            if viewController.isKind(of: HomeVC.classForCoder()){
                viewController.navigationController?.isNavigationBarHidden = false
                viewController.navigationItem.leftBarButtonItem = leftBarButton
                viewController.navigationItem.rightBarButtonItems = nil
                let appearance = UINavigationBarAppearance()
                let blurEffect = UIBlurEffect(style: .dark)
                appearance.backgroundEffect = blurEffect
                appearance.backgroundColor = .black.withAlphaComponent(0.5)
                viewController.navigationController?.navigationBar.standardAppearance = appearance
                if #available(iOS 15.0, *) {
                    viewController.navigationController?.navigationBar.scrollEdgeAppearance = appearance
                }
            }else{
                viewController.navigationController?.isNavigationBarHidden = true
            }
            break
        default:
            viewController.navigationController?.isNavigationBarHidden = false
            viewController.tabBarController?.tabBar.isHidden = true
            break
        }
    }
}
