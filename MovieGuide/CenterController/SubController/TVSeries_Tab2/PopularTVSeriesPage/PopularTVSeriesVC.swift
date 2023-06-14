//
//  PopularTVSeriesVC.swift
//  MovieGuide
//
//  Created by CallmeOni on 14/6/2566 BE.
//

import UIKit
import Gemini

class PopularTVSeriesVC: UIViewController {

    @IBOutlet weak var cltvPopularTvSeries: GeminiCollectionView!
    private let reuseIdenCell = "PopularCell"
    private var poppularData:[TvPopularModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCltv()
        self.configureAnimation()
        self.fetchDataPopular()
    }
    
    func fetchDataPopular(){
        APITVSeries.getTvShowPopular { resultData, err in
            if let data = resultData{
                self.poppularData = data.tvPopularModel
                
                DispatchQueue.main.async {
                    self.collectioViewSetup(sender: self.cltvPopularTvSeries)
                }
            }
        }
    }
    
    private func setupCltv(){
        cltvPopularTvSeries.register(UINib(nibName: "PupularViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdenCell)
        cltvPopularTvSeries.dataSource = self
        cltvPopularTvSeries.delegate = self
        cltvPopularTvSeries.contentInsetAdjustmentBehavior = .never
    }
    
    func collectioViewSetup( sender: UICollectionView) {
        switch sender{
        case cltvPopularTvSeries:
            let layout = UICollectionViewPagingFlowLayout()
            layout.itemSize = CGSize(width: self.cltvPopularTvSeries.bounds.width - 100, height: self.cltvPopularTvSeries.bounds.height - 100)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
            layout.minimumLineSpacing = 10
            layout.scrollDirection = .horizontal
            self.cltvPopularTvSeries.collectionViewLayout = layout
            self.cltvPopularTvSeries.reloadData()
        default:
            break
        }
    }
    
    func configureAnimation() {
        cltvPopularTvSeries.gemini
            .customAnimation()
            .translation(x:0, y: 50, z:0)
            .rotationAngle(x:0, y: 13, z:0)
            .ease(.easeOutExpo)
            .shadowEffect(.fadeIn)
            .maxShadowAlpha(0.3)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        cltvPopularTvSeries.animateVisibleCells()
    }
}

extension PopularTVSeriesVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poppularData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdenCell, for: indexPath) as! PupularViewCell
        let md = poppularData[indexPath.row]
        cell.setUI(md: md)
        self.cltvPopularTvSeries.animateCell(cell)
        return cell
    }
}

extension PopularTVSeriesVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.cltvPopularTvSeries.animateCell(cell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let md = poppularData[indexPath.row]
        if let id = md.id{
            let vc = DetailSelectVC()
            vc.idInput = id
            vc.type = .tvSeries
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
