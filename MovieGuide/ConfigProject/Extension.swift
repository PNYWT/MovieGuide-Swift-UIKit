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

//MARK: extension UILabel
extension UILabel{
    func addShadowLabel(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2.0
    }
}

extension UIImageView{
    func getImageDataFrom(url: URL){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty Data")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.image = image
                }
            }
        }.resume()
    }
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

//MARK: extension UIColor
extension UIColor{
    
    static let customRed = UIColor.init(hex: "d12d43")
    static let customSky = UIColor.init(hex: "87CEEB")
    static let custom100Blue = UIColor.init(hex: "d0d9ff")
    
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        guard hexString.count == 6 else {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

//MARK: CltvFlowLayout
final class UICollectionViewPagingFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }

        let offset = isVertical ? collectionView.contentOffset.y : collectionView.contentOffset.x
        let velocity = isVertical ? velocity.y : velocity.x

        let flickVelocityThreshold: CGFloat = 0.2
        let currentPage = offset / pageSize

        if abs(velocity) > flickVelocityThreshold {
            let nextPage = velocity > 0.0 ? ceil(currentPage) : floor(currentPage)
            let nextPosition = nextPage * pageSize
            return isVertical ? CGPoint(x: proposedContentOffset.x, y: nextPosition) : CGPoint(x: nextPosition, y: proposedContentOffset.y)
        } else {
            let nextPosition = round(currentPage) * pageSize
            return isVertical ? CGPoint(x: proposedContentOffset.x, y: nextPosition) : CGPoint(x: nextPosition, y: proposedContentOffset.y)
        }
    }

    private var isVertical: Bool {
        return scrollDirection == .vertical
    }

    private var pageSize: CGFloat {
        if isVertical {
            return itemSize.height + minimumInteritemSpacing
        } else {
            return itemSize.width + minimumLineSpacing
        }
    }
}

//MARK: UIView
extension UIView{
    
    func addShadow(color: UIColor = UIColor.black, opacity: Float = 0.4, offset: CGSize = CGSize(width: 0, height: 4), radius: CGFloat = 2) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}

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

//MARK: UITextField
extension UITextField {
    func addMove() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
            if !self.isFirstResponder {
                return
            }
            
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
              return
            }
            
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let win = windowScene.windows.first {
                var shouldMoveViewUp = false
                let bottomOfTextField = self.convert(self.bounds, to: win.visibleViewController()?.view).maxY;
                  
                let topOfKeyboard = (win.visibleViewController()?.view.frame.height)! - keyboardSize.height
                if bottomOfTextField > topOfKeyboard {
                    shouldMoveViewUp = true
                }
                if(shouldMoveViewUp) {
                    win.frame.origin.y = 0 - keyboardSize.height
                }
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { notification in
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let win = windowScene.windows.first {
//                UIApplication.shared.windows.first?.frame.origin.y = 0
                win.frame.origin.y = 0
            }
        }
    }
}

//MARK: Font
extension UIFont{
    static let font18 = UIFont.systemFont(ofSize: 18)
    static let font18Bold = UIFont.boldSystemFont(ofSize: 18)
}
