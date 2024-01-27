//
//  TbvPosterViewCell.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation
import UIKit

protocol TbvPosterViewCellDelegate{
    func didselectItemPoster()
}

class TbvPosterViewCell: UITableViewCell {
    
    var delegate:TbvPosterViewCellDelegate?

    static let reuseIdenCell = "TbvPosterCell"
    private lazy var cltvPoster : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MoviePosterViewCell.self, forCellWithReuseIdentifier: MoviePosterViewCell.reuseIdenCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var dataTitles:[HomeMovieDetail]! = []
    private var hideShowPlayImg:Bool! = true
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cltvPoster)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cltvPoster.frame = contentView.bounds
    }
    
    func configure(with data:[HomeMovieDetail], hideShowPlayImg:Bool = true){
        cltvPoster.collectionViewLayout = ConfigUI.makeColltionViewLayout(spaceItem: ConfigUI.defualtSpaceX1, widthItem: 101, heightItem: contentView.bounds.height - (ConfigUI.defualtSpaceX1*2), scrollDirection: .horizontal, edgeInsets: UIEdgeInsets(top: 0, left: ConfigUI.defualtSpaceX1/2, bottom:0, right: ConfigUI.defualtSpaceX1/2))
        self.dataTitles = data
        self.hideShowPlayImg = hideShowPlayImg
        DispatchQueue.main.async { [weak self] in
            self?.cltvPoster.reloadData()
        }
    }
}

extension TbvPosterViewCell:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterViewCell.reuseIdenCell, for: indexPath) as! MoviePosterViewCell
        cell.configure(withModel: dataTitles[indexPath.item], hideShowPlayImg: hideShowPlayImg)
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TbvPosterViewCell -> Select cltv row Movie")
    }
}
