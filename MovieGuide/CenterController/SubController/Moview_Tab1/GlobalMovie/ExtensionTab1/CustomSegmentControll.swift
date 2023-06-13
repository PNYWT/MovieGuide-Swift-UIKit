//
//  CustomSegmentControll.swift
//  MovieGuide
//
//  Created by CallmeOni on 13/6/2566 BE.
//

import UIKit

extension UIImage{
    class func getSegReact(color: CGColor, andSize size: CGSize)-> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context?.fill(rectangle)
        
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rectangleImage!
    }
}

extension UISegmentedControl{
    //remove bottom border when not selected
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func removeBorder(){
        //background color segment
        let background = UIImage.getSegReact(color: UIColor.lightGray.cgColor.copy(alpha: 0.5)!, andSize: self.bounds.size)
        self.setBackgroundImage(background, for: .normal, barMetrics: .default)
        self.setBackgroundImage(background, for: .selected, barMetrics: .default)
        self.setBackgroundImage(background, for: .highlighted, barMetrics: .default)
        
        // this is | between segment
        let deviderLine = UIImage.getSegReact(color: UIColor.lightGray.cgColor.copy(alpha: 0.5)!, andSize: CGSize(width: 1, height: self.bounds.size.height))
        self.setDividerImage(deviderLine, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        
        //non select
        let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                //Custom Font here
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        
        //select
        let selectedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red,
                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        self.setTitleTextAttributes(normalAttributes as [NSAttributedString.Key : Any], for: .normal)
        self.setTitleTextAttributes(selectedAttributes as [NSAttributedString.Key : Any], for: .selected)
        
        self.layer.cornerRadius = 16
    }
    
    func setupSegmentUnderLine() {
        self.removeBorder()
        let segmentUnderlineWidth: CGFloat = self.bounds.width
        let segmentUnderlineHeight: CGFloat = 2.0
        let segmentUnderlineXPosition = self.bounds.minX
        let segmentUnderLineYPosition = self.bounds.size.height - segmentUnderlineHeight
        let segmentUnderlineFrame = CGRect(x: segmentUnderlineXPosition, y: segmentUnderLineYPosition, width: segmentUnderlineWidth, height: segmentUnderlineHeight)
        let segmentUnderline = UIView(frame: segmentUnderlineFrame)
        segmentUnderline.backgroundColor = UIColor.clear
        self.addSubview(segmentUnderline)
        self.highlighSelectedSegment()
    }
    
    //tab highlight when select
    
    func highlighSelectedSegment(){
        DispatchQueue.main.async(){
            self.removeBorder()
            
            let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
            let underlineHeight: CGFloat = 4.0
            let underlineXPosition = CGFloat(self.selectedSegmentIndex * Int(underlineWidth))
            let underLineYPosition = self.bounds.size.height - underlineHeight
            let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
            let underline = UIView(frame: underlineFrame)
            underline.backgroundColor = UIColor.red
            underline.layer.cornerRadius = underlineHeight/2
            underline.tag = 1
            self.addSubview(underline)
        }
    }
    
    //set the position of botton unberline
    func underlinePosition(){
        guard let underLine = self.viewWithTag(1)else {return}
        let xPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        
        UIView.animate(withDuration: 0.3) {
            underLine.frame.origin.x = xPosition
        }
    }
}

