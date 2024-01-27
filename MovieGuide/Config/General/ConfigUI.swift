//
//  ConfigUI.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation
import UIKit

class ConfigUI{
    
    static let defualtSpaceX1 = 8.0
    
    //MARK: CollectionView
    static func makeColltionViewLayout(spaceItem:CGFloat = 0, widthItem:CGFloat, heightItem:CGFloat, scrollDirection:UICollectionView.ScrollDirection = .vertical, edgeInsets:UIEdgeInsets = .zero) -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthItem, height: heightItem)
        layout.minimumInteritemSpacing = spaceItem// ระยะห่างระหว่าง items ในแถวเดียวกัน
        layout.minimumLineSpacing = spaceItem // ระยะห่างระหว่างแถว
        layout.sectionInset = edgeInsets
        layout.scrollDirection = scrollDirection
        return layout
    }
    
    static func calculateSizeRatioView(mainWidth:CGFloat, widthFigma:CGFloat,heightFigma:CGFloat) -> CGSize{ //ใช้กรณี fix width view
        let screenWidth = mainWidth
        let scaleFactor = screenWidth / widthFigma
        return CGSize(width: screenWidth, height: heightFigma * scaleFactor)
    }
    
    static func makeCornerRadius(view:UIView, radius:CGFloat, needBorder:Bool=false, ifNeedWhatColor:UIColor = .white, ifNeedWhatWidth:CGFloat = 1.0){
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
        
        if needBorder{
            view.layer.borderColor = ifNeedWhatColor.cgColor
            view.layer.borderWidth = ifNeedWhatWidth
        }
    }
}

extension UILabel{
    func createNormalLabel(numberOfLines:Int = 1, textAlignment:NSTextAlignment = .center, textColor:UIColor = .white, font:UIFont = .systemFont(ofSize: 12)){
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.font = font
    }
}

extension UIView {
    var parentVCofUIView: UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
