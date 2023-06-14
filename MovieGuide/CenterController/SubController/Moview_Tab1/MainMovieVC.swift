//
//  ViewController.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import UIKit
import CoreLocation

class MainMovieVC: UIViewController {
    @IBOutlet weak var scrMovie: UIScrollView!
    @IBOutlet weak var segmentControlMovie: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrMovie.delegate = self
        scrMovie.isPagingEnabled = true
        scrMovie.showsHorizontalScrollIndicator = false
        scrMovie.contentInsetAdjustmentBehavior = .never
        setupScrollView()
    }
    
    func segmentSetUp(){
        DispatchQueue.main.async {
            self.segmentControlMovie.setTitle("Popular", forSegmentAt: 0)
            self.segmentControlMovie.setTitle("Top Rated", forSegmentAt: 1)
            self.segmentControlMovie.selectedSegmentIndex = 0
            self.segmentControlMovie.setupSegmentUnderLine()
            self.selectSegment(self.segmentControlMovie)
        }
    }

    func setupScrollView() {
        DispatchQueue.main.async {
            for page in 0..<2 {
                if page == 0 {
                    let firstPage = PopularMovieVC()
                    firstPage.view.frame = CGRect(x: CGFloat(page) * self.view.frame.width, y: 0, width: self.view.frame.width, height: self.scrMovie.frame.size.height)
                    firstPage.view.layoutSubviews()
                    self.addChild(firstPage)
                    self.scrMovie.addSubview(firstPage.view)
                    self.scrMovie.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    firstPage.didMove(toParent: self)
                }else if page == 1{
                    let secondPage = TopRateMovieVC()
                    secondPage.view.frame = CGRect(x: CGFloat(page) * self.view.frame.width, y: 0, width: self.view.frame.width, height: self.scrMovie.frame.size.height)
                    secondPage.view.layoutSubviews()
                    self.addChild(secondPage)
                    self.scrMovie.addSubview(secondPage.view)
                    self.scrMovie.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    secondPage.didMove(toParent: self)
                }
            }
            self.scrMovie.contentSize = CGSize(width: self.view.frame.size.width * 2, height: self.scrMovie.frame.size.height)
            self.segmentSetUp()
        }
    }
    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        DispatchQueue.main.async(){
            sender.underlinePosition()
            self.loadViewController(idx: sender.selectedSegmentIndex)
        }
    }
}

extension MainMovieVC : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let w = scrollView.frame.size.width
        let page = scrollView.contentOffset.x / w
        segmentControlMovie.selectedSegmentIndex = Int(round(page))
        segmentControlMovie.underlinePosition()
    }
    
    func loadViewController(idx: Int) {
        let x = scrMovie.frame.size.width * CGFloat(idx)
        self.scrMovie.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
}
