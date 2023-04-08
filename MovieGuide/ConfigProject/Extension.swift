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

func convertToTimeFormat(_ minutes: Int) -> String {
    let hours = minutes / 60
    let minutes = minutes % 60
    let hoursString = String(format: "%2d", hours)
    let minutesString = String(format: "%02d", minutes)
    return "\(hoursString)h \(minutesString)m"
}

//MARK: Add addShadow
func addShadow(to label: UILabel, withOffset offset: CGSize) {
    label.layer.shadowColor = UIColor.black.cgColor
    label.layer.shadowOffset = offset
    label.layer.shadowOpacity = 1.0
    label.layer.shadowRadius = 2.0
}

//MARK: Add color AttributedString
func getAttributedString(arrayText:[String]?, arrayColors:[UIColor]?, arrayFonts:[UIFont]?) -> NSMutableAttributedString {
    let finalAttributedString = NSMutableAttributedString()
    for i in 0 ..< (arrayText?.count)! {
        let attributes = [NSAttributedString.Key.foregroundColor: arrayColors?[i], NSAttributedString.Key.font: arrayFonts?[i]]
        let attributedStr = (NSAttributedString.init(string: arrayText?[i] ?? "", attributes: attributes as [NSAttributedString.Key : Any]))
        if i != 0 {
            finalAttributedString.append(NSAttributedString.init(string: " "))
        }
        finalAttributedString.append(attributedStr)
    }
    return finalAttributedString
}

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


class KeysUSDF{
    static let saveLogin = "saveLogin"
}
