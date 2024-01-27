//
//  ConfigPresentVC.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation
import UIKit

enum TypePresent{
    case push
    case present
}

class ConfigPresentVC{
    static func uiViewPushNormal(typeShowPage:TypePresent, ifPresentWhatStyle:UIModalPresentationStyle = .formSheet, fromView:UIView, goWhere:UIViewController, completionWorking:((_ showPageSuccess:Bool)->Void)? = nil)->Void{
        switch typeShowPage{
        case .push:
            DispatchQueue.main.async {
                if let mainVC = fromView.parentVCofUIView{
                    mainVC.navigationController?.pushViewController(goWhere, animated: true)
                    completionWorking?(true)
                }
            }
            break
        case .present:
            DispatchQueue.main.async {
                if let mainVC = fromView.parentVCofUIView{
                    mainVC.modalPresentationStyle = ifPresentWhatStyle
                    mainVC.present(goWhere, animated: true) {
                        completionWorking?(true)
                    }
                }
            }
            break
        }
    }
}
