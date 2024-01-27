//
//  File.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation
import UIKit
import SDWebImage

class MoviePosterViewCell: UICollectionViewCell {
    
    static let reuseIdenCell = "MoviePosterCell"

    private lazy var posterImg: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.contentMode = .scaleAspectFill
        return posterImageView
    }()
    
    private lazy var watchNowImg: UIImageView = {
        let watchNowImage = UIImageView()
        watchNowImage.contentMode = .scaleAspectFit
        watchNowImage.image = UIImage(systemName: "play.fill")
        watchNowImage.isHidden = true
        watchNowImage.backgroundColor = .clear
        return watchNowImage
    }()
    
    private lazy var lbTitle: UILabel = {
        let label = UILabel()
        label.createNormalLabel()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImg)
        contentView.addSubview(watchNowImg)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImg.frame.size.height = bounds.height
        posterImg.frame.size.width = contentView.bounds.width - 2
        posterImg.frame.origin.y = 2
        posterImg.frame.origin.x = (contentView.bounds.width - posterImg.frame.size.width)/2
        ConfigUI.makeCornerRadius(view: posterImg, radius: 10)
        
        watchNowImg.frame.size = CGSize(width: 40, height: 40)
        watchNowImg.frame.origin.x = (contentView.bounds.width - 40)/2
        watchNowImg.frame.origin.y = (posterImg.frame.size.height - 40)/2
    }

    func configure(withModel model: HomeMovieDetail, hideShowPlayImg:Bool = true) {
        guard let pathMoview = model.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(pathMoview)") else {
            return
        }
        posterImg.sd_setImage(with: url, completed: nil)
        if let title = model.original_name{
            lbTitle.text = title
        }else{
            lbTitle.text = model.original_title
        }
        watchNowImg.isHidden = hideShowPlayImg
    }
}


