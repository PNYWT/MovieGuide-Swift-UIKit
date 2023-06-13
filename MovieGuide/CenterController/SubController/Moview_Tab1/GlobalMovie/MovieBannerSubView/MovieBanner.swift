//
//  MovieBanner.swift
//  MovieGuide
//
//  Created by Dev on 26/3/2566 BE.
//

import UIKit

protocol MovieBannerDelegate{
    func didselectIndex(movieId:Int)
}

class MovieBanner: UIView{
    var delegate:MovieBannerDelegate?
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var cltvBanner: UICollectionView!
    @IBOutlet weak var pagecontrolCltv: UIPageControl!
    private let reuseIden = "BannerCell"
    
    private var dataBanner:[UpComingModel] = []
    private var fakeIndex = 0
    
    var timer: Timer?
    
    // Custom init method
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    // Required init method
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    func acceptDataBanner(md:[UpComingModel]?){
        if let md_Tmp = md{
            dataBanner = md_Tmp
            setupCltv()
        }
    }
    
    private func commitInit(){
        Bundle.main.loadNibNamed("MovieBanner", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupCltv(){
        cltvBanner.delegate = self
        cltvBanner.dataSource = self
        cltvBanner.register(UINib(nibName: "MoviewBannerViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIden)
        cltvBanner.alwaysBounceHorizontal = true
        cltvBanner.showsHorizontalScrollIndicator = false
        collectioViewSetup(sender: cltvBanner)
        scrollingsetupTimmer()
        if dataBanner.count > 0{
            pagecontrolCltv.numberOfPages = dataBanner.count
        }
    }
    
    func scrollingsetupTimmer(){
        if dataBanner.count > 0{
            timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollingSetup), userInfo: nil, repeats: true)
        }
    }
    
    @objc func scrollingSetup(){
        if fakeIndex < dataBanner.count - 1{
            fakeIndex += 1
        }else{
            fakeIndex = 0
        }
        
        pagecontrolCltv.currentPage = fakeIndex
        pagecontrolCltv.reloadInputViews()
        cltvBanner.scrollToItem(at: IndexPath(item: fakeIndex, section: 0), at: .right, animated: true)
    }
    
    func collectioViewSetup( sender: UICollectionView) {
        let xSpace:CGFloat = 0
        let layoutCollectionView = UICollectionViewFlowLayout()
        sender.backgroundColor = .clear
        
        switch sender{
        case cltvBanner:
            let wItem:CGFloat = self.cltvBanner.frame.width
            let hItem:CGFloat = self.cltvBanner.frame.height
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

extension MovieBanner: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataBanner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIden, for: indexPath) as! MoviewBannerViewCell
        let md:UpComingModel = dataBanner[indexPath.row]
        cell.setUI(md: md)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let md:UpComingModel = dataBanner[indexPath.row]
        if let id = md.idTopMovie{
            self.delegate?.didselectIndex(movieId: id)
        }
    }
}
