//
//  HeaderTbvScrollMovie.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation
import UIKit
import Gemini

class HeaderTbvScrollMovie: UIView {
    
    private var dataPoster:[HomeMovieDetail]!
    private var timerInfiniteScroll: Timer?
    private var _timeInterval:CGFloat! = 3.0
    var timeInterval:CGFloat{
        get{ //getter
            return _timeInterval
        }set (newTime) { //setter
            if newTime > 0.0{
                _timeInterval = newTime
            }
        }
    }
    private var isAutoScrolling = true

    private lazy var cltvHeader: GeminiCollectionView = {
        let layout = UICollectionViewPagingFlowLayout()
        let calSizeCell = ConfigUI.calculateSizeRatioView(mainWidth: self.bounds.width, widthFigma: 376, heightFigma: 477)
        layout.itemSize = CGSize(width: calSizeCell.width - 76, height: calSizeCell.height - 20)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 76/2, bottom: 10, right: 76/2)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        let collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CltvHeaderViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdenCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let reuseIdenCell = "CltvHeaderCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        dataPoster = []
        setUIView()
        getData()
    }
    
    private func setUIView(){
        cltvHeader.frame = self.bounds
        cltvHeader.backgroundColor = .clear
        self.addSubview(cltvHeader)
        cltvHeader.gemini
            .customAnimation()
            .translation(x:0, y: 50, z:0)
            .rotationAngle(x:0, y: 13, z:0)
            .ease(.easeOutExpo)
            .shadowEffect(.fadeIn)
            .maxShadowAlpha(0.3)
        cltvHeader.reloadData()
    }
    
    private func getData(){
        CustomService.getTrendingTv { result in
            switch result {
            case .success(let dataMovie):
                self.dataPoster = dataMovie
                DispatchQueue.main.async { [weak self] in
                    self?.cltvHeader.reloadData()
                    if dataMovie.count > 0 {
                        self?.cltvHeader.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredVertically, animated: false)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: Auto Scroll
    //กำหนดตัว timeInterval ก่อนเรียกใช้ setupTimer ไม่งั้น defualt จะได้ 3.0
    func setupTimer() {
        timerInfiniteScroll = Timer.scheduledTimer(timeInterval: _timeInterval, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        if !isAutoScrolling {
            return
        }
        
        if cltvHeader.isDragging || cltvHeader.isDecelerating || cltvHeader.isTracking {
            return
        }
        
        let currentOffset = cltvHeader.contentOffset
        let itemWidth = cltvHeader.frame.size.width - 76 + 20
        let nextOffset = CGPoint(x: currentOffset.x + itemWidth, y: currentOffset.y)
        
        if nextOffset.x >= cltvHeader.contentSize.width - itemWidth {
            cltvHeader.setContentOffset(.zero, animated: false) // กลับไปที่ต้น array ถ้าถึงสุด
        } else {
            cltvHeader.setContentOffset(nextOffset, animated: true)
        }
    }

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timerInfiniteScroll?.invalidate() // หยุด auto scroll เมื่อ user กำลัง scroll
        isAutoScrolling = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isAutoScrolling = true
        setupTimer()
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        cltvHeader.animateVisibleCells()
    }
}

extension HeaderTbvScrollMovie:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPoster.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdenCell, for: indexPath) as! CltvHeaderViewCell
        cell.configure(withModel: dataPoster[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.isUserInteractionEnabled = false
        print("HeaderViewTbvMovie -> Select Movie")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.cltvHeader.animateCell(cell)
        }
    }
}
