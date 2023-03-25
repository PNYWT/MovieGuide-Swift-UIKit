//
//  GenresViewCell.swift
//  MovieGuide
//
//  Created by Dev on 25/3/2566 BE.
//

import UIKit

class GenresViewCell: UICollectionViewCell {

    @IBOutlet weak var lbGenres: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lbGenres.backgroundColor = .lightGray
        self.lbGenres.layer.cornerRadius = 10
        self.lbGenres.layer.masksToBounds = true
    }

}
