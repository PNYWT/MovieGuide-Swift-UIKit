//
//  PopularMovieViewCell.swift
//  MovieGuide
//
//  Created by Dev on 25/3/2566 BE.
//

import UIKit
import SDWebImage

class PopularMovieViewCell: UITableViewCell {
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    
    @IBOutlet weak var yearMovie: UILabel!
    @IBOutlet weak var detailMovie: UILabel!
    @IBOutlet weak var rateMovie: UILabel!
    
    private var urlString: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?) {
        
        self.titleMovie.text = title
        self.titleMovie.font = UIFont.boldSystemFont(ofSize: 18)
        self.detailMovie.text = overview
        self.yearMovie.text = convertDateFormater(releaseDate)
        guard let rate = rating else {return}
        self.rateMovie.text = String.init(format: "Score: %@/10", "\(rate)")
        
        
        guard let posterString = poster else {return}
        imgMovie.sd_setImage(with: URL(string: DomainPath.pathImg(posterString: posterString)))
    }
}
