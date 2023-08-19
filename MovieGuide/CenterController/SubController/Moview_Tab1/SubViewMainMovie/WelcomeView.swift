//
//  WelcomeView.swift
//  MovieGuide
//
//  Created by CallmeOni on 19/8/2566 BE.
//

import UIKit

class WelcomeView: UIView {

    @IBOutlet weak var parentView:UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commitInit()
    }
    
    func commitInit(){
        Bundle.main.loadNibNamed("WelcomeView", owner: self)
        addSubview(parentView)
        parentView.frame = self.bounds
        parentView.backgroundColor = .red
    }
}
