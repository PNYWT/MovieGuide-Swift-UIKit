//
//  CltvHeaderViewCell.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import UIKit
import Gemini

class CltvHeaderViewCell: GeminiCell {
    
    
    @IBOutlet weak var imagePoster:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagePoster.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        ConfigUI.makeCornerRadius(view: imagePoster, radius: 10)
    }
    
    func configure(withModel model: HomeMovieDetail) {
        guard let pathMoview = model.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(pathMoview)") else {
            return
        }
        imagePoster.sd_setImage(with: url, completed: nil)
    }
    
}
