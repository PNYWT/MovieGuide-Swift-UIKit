//
//  TVshowViewCell.swift
//  MovieGuide
//
//  Created by Dev on 28/3/2566 BE.
//

import UIKit

class TVshowViewCell: UICollectionViewCell {

    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbName: UILabel!
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
            self.imgPoster.image = nil
            print("posterImageURL -> \(posterImageURL)")
            getImageDataFrom(url: posterImageURL)
            
            
            guard let name = md_Tmp.titleName else {
                lbName.text = ""
                return
            }
            lbName.text = name
            lbName.font = UIFont.boldSystemFont(ofSize: 14)
            lbName.textColor = .systemBlue
            lbName.shadowOffset = CGSize(width: 1, height: 1)
            addShadow(to: lbName, withOffset: CGSize(width: 1.0, height: 1.0))
            
            guard let score = md_Tmp.rateing else{
                lbScore.text = ""
                return
            }
            lbScore.text = "Score: \(score)"
            lbScore.font = UIFont.boldSystemFont(ofSize: 12)
            lbScore.textColor = .yellow
        
            
        }
    }
    
    // MARK: - Get image data
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
                    self.imgPoster.image = image
                }
            }
        }.resume()
    }
}
