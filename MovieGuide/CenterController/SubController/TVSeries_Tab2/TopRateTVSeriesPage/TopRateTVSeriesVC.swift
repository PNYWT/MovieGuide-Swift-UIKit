//
//  TopRateTVSeriesVC.swift
//  MovieGuide
//
//  Created by CallmeOni on 14/6/2566 BE.
//

import UIKit

class TopRateTVSeriesVC: UIViewController {

    @IBOutlet weak var lbTopRate: UILabel!
    @IBOutlet weak var cltvTvShowTopRate: UICollectionView!
    private var tvTopRate:[TvTopRateModel] = []
    private let reuseIden = "TVshowCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCltv()
        self.loadData()
    }
    
    override func viewDidLayoutSubviews() {
        self.lbTopRate.addShadowLabel()
    }
    
    private func loadData(){
        APITVSeries.getTvShowTopRate { md, err in
            if let mdTmp = md {
                self.tvTopRate = mdTmp.tvTopRateModel
            }else{
                
            }
            DispatchQueue.main.async {
                self.collectioViewSetup(sender: self.cltvTvShowTopRate)
            }
        }
    }
    
    private func setupCltv(){
        cltvTvShowTopRate.delegate = self
        cltvTvShowTopRate.dataSource = self
        cltvTvShowTopRate.register(UINib(nibName: "TVshowViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIden)
        cltvTvShowTopRate.alwaysBounceHorizontal = true
        cltvTvShowTopRate.showsHorizontalScrollIndicator = false
        collectioViewSetup(sender: cltvTvShowTopRate)
    }
    
    func collectioViewSetup( sender: UICollectionView) {
        let xSpace:CGFloat = 5
        let layoutCollectionView = UICollectionViewFlowLayout()
        sender.backgroundColor = .clear
        
        switch sender{
        case cltvTvShowTopRate:
            let numItemInRow:CGFloat = 2
            var wItemList:CGFloat = 0
            var hItemList:CGFloat = 0
            wItemList = ((cltvTvShowTopRate.bounds.width - CGFloat(xSpace*3)) / numItemInRow) - 0.2
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
            self.cltvTvShowTopRate.reloadData()
        default:
            break
         }
     }

}

extension TopRateTVSeriesVC:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvTopRate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIden, for: indexPath) as! TVshowViewCell
        let md:TvTopRateModel = tvTopRate[indexPath.row]
        cell.setUI(md: md)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let md:TvTopRateModel = tvTopRate[indexPath.row]
        if let id = md.idTV{
            let vc = DetailSelectVC.init()
            vc.idInput = id
            vc.type = .tvSeries
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
