//
//  TVshowViewCell.swift
//  MovieGuide
//
//  Created by Dev on 28/3/2566 BE.
//

import UIKit
import SDWebImage

class TVshowViewCell: UICollectionViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUITopRate(md:TvTopRateModel?){
        if let md_Tmp = md{
            guard let posterString = md_Tmp.posterImageURL else {return}
            imgPoster.sd_setImage(with: URL(string: DomainPath.pathImg(posterString: posterString)))
        }
    }
    
    func setUIPopular(md:TvPopularModel?){
        if let md_Tmp = md{
            guard let posterString = md_Tmp.poster_path else {return}
            imgPoster.sd_setImage(with: URL(string: DomainPath.pathImg(posterString: posterString)))
        }
    }
}
