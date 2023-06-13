//
//  ViewController.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import UIKit
import CoreLocation

class MainMovieVC: UIViewController {
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrView.delegate = self
        scrView.isPagingEnabled = true
        scrView.showsHorizontalScrollIndicator = false
        scrView.contentInsetAdjustmentBehavior = .never
        setupScrollView()
    }
    
    func segmentSetUp(){
        DispatchQueue.main.async {
            self.segmentControl.setTitle("Popular", forSegmentAt: 0)
            self.segmentControl.setTitle("Top Rated", forSegmentAt: 1)
            self.segmentControl.selectedSegmentIndex = 0
            self.segmentControl.setupSegmentUnderLine()
            self.selectSegment(self.segmentControl)
        }
    }

    func setupScrollView() {
        DispatchQueue.main.async {
            for page in 0..<2 {
                if page == 0 {
                    let firstPage = FirstMovieVC()
                    firstPage.view.frame = CGRect(x: CGFloat(page) * self.view.frame.width, y: 0, width: self.view.frame.width, height: self.scrView.frame.size.height)
                    firstPage.view.layoutSubviews()
                    self.addChild(firstPage)
                    self.scrView.addSubview(firstPage.view)
                    self.scrView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    firstPage.didMove(toParent: self)
                }else if page == 1{
                    let secondPage = SecondMovieVC()
                    secondPage.view.frame = CGRect(x: CGFloat(page) * self.view.frame.width, y: 0, width: self.view.frame.width, height: self.scrView.frame.size.height)
                    secondPage.view.layoutSubviews()
                    self.addChild(secondPage)
                    self.scrView.addSubview(secondPage.view)
                    self.scrView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    secondPage.didMove(toParent: self)
                }
            }
            self.scrView.contentSize = CGSize(width: self.view.frame.size.width * 2, height: self.scrView.frame.size.height)
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
        segmentControl.selectedSegmentIndex = Int(round(page))
        segmentControl.underlinePosition()
    }
    
    func loadViewController(idx: Int) {
        let x = scrView.frame.size.width * CGFloat(idx)
        self.scrView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
}
