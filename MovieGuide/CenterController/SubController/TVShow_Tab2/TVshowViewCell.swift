//
//  TVshowViewCell.swift
//  MovieGuide
//
//  Created by Dev on 28/3/2566 BE.
//

import UIKit

class TVshowViewCell: UICollectionViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(md:TvTopRateModel?){
        if let md_Tmp = md{
            guard let posterString = md_Tmp.posterImageURL else {return}
            let urlString = DomainPath.pathImg(posterString: posterString)
            
            guard let posterImageURL = URL(string: urlString) else {
                self.imgPoster.image = UIImage.init(systemName: "")
                return
            }
            self.imgPoster.getImageDataFrom(url: posterImageURL)
        }
    }
}
