//
//  TVShowVC.swift
//  MovieGuide
//
//  Created by Dev on 28/3/2566 BE.
//

import UIKit

class TVShowVC: UIViewController {

    @IBOutlet weak var cltvTvShowTopRate: UICollectionView!
    private var tvTopRate:[TvTopRateModel] = []
    private let reuseIden = "TVshowCell"
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCltv()
    }
    
    private func loadData(){
        APITv.getTvShowTopRate { md, err in
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
            let wItem:CGFloat = self.cltvTvShowTopRate.frame.width*0.3
            let hItem:CGFloat = self.cltvTvShowTopRate.frame.height - 10
            layoutCollectionView.itemSize = CGSize.init(width: wItem, height: hItem)
            layoutCollectionView.minimumInteritemSpacing = CGFloat(xSpace)
            layoutCollectionView.minimumLineSpacing      = CGFloat(xSpace)
            layoutCollectionView.scrollDirection = .horizontal
            sender.collectionViewLayout = layoutCollectionView
            sender.contentInset = UIEdgeInsets(top: 0, left: CGFloat(xSpace), bottom: 0, right: CGFloat(xSpace))
            sender.reloadData()
        default:
            break
        }
    }
}

extension TVShowVC:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvTopRate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIden, for: indexPath) as! TVshowViewCell
        let md:TvTopRateModel = tvTopRate[indexPath.row]
        cell.setUI(md: md)
        return cell
    }
    
    
}
