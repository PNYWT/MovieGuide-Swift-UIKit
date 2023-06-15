//
//  OnAirTVSeriesVC.swift
//  MovieGuide
//
//  Created by CallmeOni on 14/6/2566 BE.
//

import UIKit

class OnAirTVSeriesVC: UIViewController {

    @IBOutlet weak var lbTitleOnAir: UILabel!
    @IBOutlet weak var cltvOnAirTvSeries: UICollectionView!
    private var onAirRate:[TvPopularModel] = []
    private let reuseIden = "TVshowCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCltv()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        self.lbTitleOnAir.addShadowLabel()
    }
    
    private func loadData(){
        APITVSeries.getTvShowOnAir { md, err in
            if let mdTmp = md {
                self.onAirRate = mdTmp.tvPopularModel
            }else{
                
            }
            DispatchQueue.main.async {
                self.collectioViewSetup(sender: self.cltvOnAirTvSeries)
            }
        }
    }
    
    private func setupCltv(){
        cltvOnAirTvSeries.delegate = self
        cltvOnAirTvSeries.dataSource = self
        cltvOnAirTvSeries.register(UINib(nibName: "TVshowViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIden)
        cltvOnAirTvSeries.alwaysBounceHorizontal = true
        cltvOnAirTvSeries.showsHorizontalScrollIndicator = false
        collectioViewSetup(sender: cltvOnAirTvSeries)
    }
    
    func collectioViewSetup( sender: UICollectionView) {
        let xSpace:CGFloat = 5
        let layoutCollectionView = UICollectionViewFlowLayout()
        sender.backgroundColor = .clear
        
        switch sender{
        case cltvOnAirTvSeries:
            let numItemInRow:CGFloat = 2
            var wItemList:CGFloat = 0
            var hItemList:CGFloat = 0
            wItemList = ((cltvOnAirTvSeries.bounds.width - CGFloat(xSpace*3)) / numItemInRow) - 0.2
            hItemList = wItemList + (wItemList*0.40)
            layoutCollectionView.minimumInteritemSpacing = CGFloat(xSpace)
            layoutCollectionView.minimumLineSpacing      = CGFloat(xSpace)
            layoutCollectionView.itemSize = CGSize.init(width: wItemList, height: hItemList)
            layoutCollectionView.scrollDirection = .vertical
            layoutCollectionView.estimatedItemSize = .zero
            sender.alwaysBounceHorizontal = false
            sender.isScrollEnabled = true
            sender.collectionViewLayout = layoutCollectionView
            sender.contentInset = UIEdgeInsets(top: CGFloat(xSpace+0.2), left: CGFloat(xSpace), bottom: CGFloat(xSpace), right: CGFloat(xSpace))
            self.cltvOnAirTvSeries.reloadData()
        default:
            break
         }
     }
}

extension OnAirTVSeriesVC:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onAirRate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIden, for: indexPath) as! TVshowViewCell
        let md:TvPopularModel = onAirRate[indexPath.row]
        cell.setUIPopular(md: md)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let md:TvPopularModel = onAirRate[indexPath.row]
        if let id = md.id{
            let vc = DetailSelectVC.init()
            vc.idInput = id
            vc.type = .tvSeries
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
