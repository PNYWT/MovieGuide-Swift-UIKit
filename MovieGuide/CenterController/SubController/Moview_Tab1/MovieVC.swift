//
//  ViewController.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import UIKit
import CoreLocation

class MovieVC: UIViewController {
    private var movieData:[PopularMovieModel] = []
    @IBOutlet weak var tbvMovie: UITableView!
    private let reuseIden = "MovieCell"
    
    @IBOutlet var vMovieBanner: MovieBanner!
    
    override func viewDidAppear(_ animated: Bool) {
        vMovieBanner.scrollingsetupTimmer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie"
        setupTbv()
        fetchData()
    }
    
    private func setupTbv(){
        tbvMovie.register(UINib(nibName: "PopularMovieViewCell", bundle: nil), forCellReuseIdentifier: reuseIden)
        tbvMovie.delegate = self
        tbvMovie.dataSource = self
    }

    private func fetchData(){
        APIMovie.getPopularMoviesData { md, err in
            if let md_tmp = md{
                self.movieData = md_tmp.moviesModel
            }
            DispatchQueue.main.async {
                self.tbvMovie.reloadData()
            }
        }
        
        APIMovie.getTopMovieData { md, err in
            if let mdTmp = md{
                DispatchQueue.main.async {
                    self.vMovieBanner.acceptDataBanner(md: mdTmp.topMovieModel)
                }
            }else{
                
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        vMovieBanner.timer?.invalidate()
        vMovieBanner.timer = nil
    }
}

extension MovieVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIden, for: indexPath) as! PopularMovieViewCell
        let md:PopularMovieModel = movieData[indexPath.row]
        cell.setupUI(title: md.title, releaseDate: md.year, rating: md.rateing, overview: md.overview, poster: md.posterImageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let md:PopularMovieModel = movieData[indexPath.row]
        if let id = md.idMovie{
            let vc = DetailSelectVC.init()
            vc.idInput = id
            vc.type = .movie
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if movieData.count > 0{
            return 50
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if movieData.count > 0{
            let headerViewHeight = 50.0
            let headerView: UIView = UIView.init()
            headerView.frame = CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: headerViewHeight)
            headerView.backgroundColor = tableView.backgroundColor
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 40, height: headerView.frame.height))
            label.text = "Popular Moview"
            label.font = UIFont.boldSystemFont(ofSize: 26)
            label.addShadowLabel()
            headerView.addSubview(label)
            return headerView
        }else{
            let headerView: UIView = UIView.init()
            headerView.frame = CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
            return headerView
        }
    }
}
