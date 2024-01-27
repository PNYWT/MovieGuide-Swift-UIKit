//
//  HeaderSectionTbvView.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation
import UIKit

class HeaderSectionTbvView: UIView {
    
//    var didSelectActionViewMore: (() -> Void)?
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.createNormalLabel(numberOfLines: 1, textAlignment: .left, font: .boldSystemFont(ofSize: 14))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var btnMore : UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(viewMore(sender:)), for: .touchUpInside)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        addSubview(titleLabel)
        addSubview(btnMore)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            btnMore.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            btnMore.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0),
            btnMore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            btnMore.widthAnchor.constraint(equalToConstant: 21),
            btnMore.heightAnchor.constraint(equalToConstant: 11)
        ])
    }

    func configure(title: String, moreBtnisHidden:Bool = true) {
        btnMore.isHidden = moreBtnisHidden
        titleLabel.text = title
    }
    
    @objc private func viewMore(sender:UIButton){
//        didSelectActionViewMore?()
        print("HeaderSectionTbvView -> View More")
    }
}
