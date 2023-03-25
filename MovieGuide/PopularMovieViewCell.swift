//
//  PopularMovieViewCell.swift
//  MovieGuide
//
//  Created by Dev on 25/3/2566 BE.
//

import UIKit

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
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.imgMovie.image = UIImage.init(systemName: "")
            return
        }
        
        // Before we download the image we clear out the old one
        self.imgMovie.image = nil
        
        getImageDataFrom(url: posterImageURL)
        
    }
    
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
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
                    self.imgMovie.image = image
                }
            }
        }.resume()
    }
    
    // MARK: - Convert date format
        func convertDateFormater(_ date: String?) -> String {
            var fixDate = ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let originalDate = date {
                if let newDate = dateFormatter.date(from: originalDate) {
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    fixDate = dateFormatter.string(from: newDate)
                }
            }
            return fixDate
        }
}
