//
//  WelcomeView.swift
//  MovieGuide
//
//  Created by CallmeOni on 19/8/2566 BE.
//

import UIKit

protocol WelcomeViewDelegate{
    func okWelcome(success:Bool)
}

class WelcomeView: UIView {
    
    var delegate:WelcomeViewDelegate?

    @IBOutlet weak var parentView:UIView!
    @IBOutlet weak var lbWelcome: UILabel!
    @IBOutlet weak var okBth: UIButton!
    
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
        parentView.backgroundColor = .custom100Blue
        
        lbWelcome.font = .font18Bold
        lbWelcome.textAlignment = .center
        lbWelcome.textColor = .customRed
        lbWelcome.numberOfLines = 0
        lbWelcome.text = "Welcome back enjoy with your movie."
        
        okBth.setTitle("OK", for: .normal)
        okBth.setTitleColor(.white, for: .normal)
        okBth.backgroundColor = .customRed
        okBth.addTarget(self, action: #selector(selectOK), for: .touchUpInside)
        okBth.layer.cornerRadius = self.okBth.frame.height/2
        okBth.layer.masksToBounds = true
    }
    
    @objc private func selectOK(){
        self.delegate?.okWelcome(success: true)
    }
}
