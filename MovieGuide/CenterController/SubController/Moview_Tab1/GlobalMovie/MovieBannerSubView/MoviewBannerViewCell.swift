//
//  MoviewBannerViewCell.swift
//  MovieGuide
//
//  Created by Dev on 26/3/2566 BE.
//

import UIKit

class MoviewBannerViewCell: UICollectionViewCell {

    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var bgBanner: UIImageView!
    @IBOutlet weak var lbScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(md:UpComingModel?){
        if let md_Tmp = md{
            guard let posterString = md_Tmp.posterImageURL else {return}
            imgBanner.sd_setImage(with: URL(string: DomainPath.pathImg(posterString: posterString)))
            bgBanner.sd_setImage(with: URL(string: DomainPath.pathImg(posterString: posterString)))
            
            if let score = md_Tmp.voteScore{
                lbScore.text = "Score: \(score)"
                lbScore.font = UIFont.boldSystemFont(ofSize: 18)
                lbScore.textColor = .systemYellow
            }else{
                lbScore.text = ""
            }
        }
    }
}
