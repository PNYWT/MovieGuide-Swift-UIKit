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
    
    func setUI(md:TopMovieModel?){
        if let md_Tmp = md{
            guard let posterString = md_Tmp.posterImageURL else {return}
            let urlString = DomainPath.pathImg(posterString: posterString)
            
            guard let posterImageURL = URL(string: urlString) else {
                self.imgBanner.image = UIImage.init(systemName: "")
                return
            }
            self.imgBanner.image = nil
            self.bgBanner.image = nil
            
            getImageDataFrom(url: posterImageURL)
            
            
            if let score = md_Tmp.voteScore{
                lbScore.text = "Score: \(score)"
                lbScore.font = UIFont.boldSystemFont(ofSize: 18)
                lbScore.textColor = .systemYellow
            }else{
                lbScore.text = ""
            }
        }
        
    }

    private func getImageDataFrom(url: URL){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty Data")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.imgBanner.image = image
                    self.bgBanner.image = image
                }
            }
        }.resume()
    }
}
