//
//  HomeVC.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import UIKit

class HomeVC: UIViewController {

    private lazy var tbvListMovie:TbvMovieHome = {
        let table = TbvMovieHome(frame: self.view.bounds, style: .grouped)
       return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTbvMain()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tbvListMovie.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    private func setupTbvMain(){
        view.backgroundColor = .white
        self.view.addSubview(tbvListMovie)
    }
}
