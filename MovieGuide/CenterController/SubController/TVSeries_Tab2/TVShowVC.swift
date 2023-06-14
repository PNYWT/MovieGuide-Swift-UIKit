//
//  TVShowVC.swift
//  MovieGuide
//
//  Created by Dev on 28/3/2566 BE.
//

import UIKit

class TVShowVC: UIViewController {
    
    @IBOutlet weak var segmentControlTV: UISegmentedControl!
    @IBOutlet weak var scrTV: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrTV.delegate = self
        scrTV.isPagingEnabled = true
        scrTV.showsHorizontalScrollIndicator = false
        scrTV.contentInsetAdjustmentBehavior = .never
        
        self.segmentSetUp()
    }
    
    func segmentSetUp(){
        DispatchQueue.main.async {
            self.segmentControlTV.setTitle("Popular", forSegmentAt: 0)
            self.segmentControlTV.setTitle("Top Rated", forSegmentAt: 1)
            self.segmentControlTV.insertSegment(withTitle: "On The Air", at: 2, animated: false)
            
            self.segmentControlTV.selectedSegmentIndex = 0
            self.segmentControlTV.setupSegmentUnderLine()
            self.setupScrollView()
        }
    }
    
    func setupScrollView() {
        DispatchQueue.main.async {
            for page in 0..<self.segmentControlTV.numberOfSegments {
                if page == 0 {
                    let firstPage = PopularTVSeriesVC()
                    firstPage.view.frame = CGRect(x: CGFloat(page) * self.view.frame.width, y: 0, width: self.view.frame.width, height: self.scrTV.frame.size.height)
                    firstPage.view.layoutSubviews()
                    self.addChild(firstPage)
                    self.scrTV.addSubview(firstPage.view)
                    self.scrTV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    firstPage.didMove(toParent: self)
                }else if page == 1{
                    let secondPage = TopRateTVSeriesVC()
                    secondPage.view.frame = CGRect(x: CGFloat(page) * self.view.frame.width, y: 0, width: self.view.frame.width, height: self.scrTV.frame.size.height)
                    secondPage.view.layoutSubviews()
                    self.addChild(secondPage)
                    self.scrTV.addSubview(secondPage.view)
                    self.scrTV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    secondPage.didMove(toParent: self)
                }else if page == 2{
                    let secondPage = OnAirTVSeriesVC()
                    secondPage.view.frame = CGRect(x: CGFloat(page) * self.view.frame.width, y: 0, width: self.view.frame.width, height: self.scrTV.frame.size.height)
                    secondPage.view.layoutSubviews()
                    self.addChild(secondPage)
                    self.scrTV.addSubview(secondPage.view)
                    self.scrTV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    secondPage.didMove(toParent: self)
                }
            }
            self.scrTV.contentSize = CGSize(width: self.view.frame.size.width * 2, height: self.scrTV.frame.size.height)
            self.segmentTV(self.segmentControlTV)
        }
    }
    @IBAction func segmentTV(_ sender: UISegmentedControl) {
        DispatchQueue.main.async(){
            sender.underlinePosition()
            self.loadViewController(idx: sender.selectedSegmentIndex)
        }
    }
    
}

extension TVShowVC : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let w = scrollView.frame.size.width
        let page = scrollView.contentOffset.x / w
        segmentControlTV.selectedSegmentIndex = Int(round(page))
        segmentControlTV.underlinePosition()
    }
    
    func loadViewController(idx: Int) {
        let x = scrTV.frame.size.width * CGFloat(idx)
        self.scrTV.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
}
