//
//  PupularViewCell.swift
//  MovieGuide
//
//  Created by CallmeOni on 14/6/2566 BE.
//

import UIKit
import Gemini

class PupularViewCell: GeminiCell {

    @IBOutlet weak var imgPoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(md:TvPopularModel?){
        if let md_Tmp = md{
            imgPoster.contentMode = .scaleAspectFill
            guard let posterString = md_Tmp.poster_path else {return}
            self.imgPoster.sd_setImage(with: URL(string: DomainPath.pathImg(posterString: posterString)))
            self.imgPoster.layer.cornerRadius = 10
            self.addShadow(color: UIColor.customRed!, opacity: 0.5, offset: CGSize(width: 10, height: 5), radius: 10)
          
        }
    }

}
