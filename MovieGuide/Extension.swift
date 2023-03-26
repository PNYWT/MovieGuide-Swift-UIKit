//
//  Extension.swift
//  MovieGuide
//
//  Created by Dev on 25/3/2566 BE.
//

import Foundation
import UIKit


class DomainPath{
    static func pathImg(posterString:String)-> String{
        return "https://image.tmdb.org/t/p/w300" + posterString
    }
}

// MARK: - Convert date format
func convertDateFormater(_ date: String?) -> String {
    var fixDate = ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    if let originalDate = date {
        if let newDate = dateFormatter.date(from: originalDate) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            fixDate = dateFormatter.string(from: newDate)
        }
    }
    return fixDate
}

func numberformatter(number:Int?) -> String{
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = ","
    if let number_Tmp = number{
        let formattedNumber = formatter.string(from: NSNumber(value: number_Tmp))!
        return formattedNumber
    }else{
        return "\(number ?? 0)"
    }
}

//extension UIViewController {
//
//    func getCurrentViewController() -> UIViewController? {
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let sceneDelegate = windowScene.delegate as? SceneDelegate,
//           let window = sceneDelegate.window {
//            return window.rootViewController?.getCurrentViewController()
//        }
//        return nil
//    }
//}

extension UIApplication {

    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
