//
//  LunachScreenVC.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import UIKit

class LunachScreenVC: UIViewController {

    @IBOutlet weak var imgLogoApp: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.startAnimating()
        self.perform(#selector(gomainNow), with: nil, afterDelay: 5.0)
    }
    
    @objc func gomainNow(){
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.duration = 0.5
        animation.repeatCount = 2
        animation.values = [-1, 1, -1, 1, -1, 1].map { NSNumber(value: $0 * Double.pi / 180) }
        animation.autoreverses = true
        imgLogoApp.layer.add(animation, forKey: "shake")

        UIView.animate(withDuration: 1.5, animations: {
            self.imgLogoApp.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            self.loadingView.stopAnimating()
            self.loadingView.isHidden = true
        }) { finished in
            ConfigGeneral.initWindows(isGoMain: true)
        }
    }
}


