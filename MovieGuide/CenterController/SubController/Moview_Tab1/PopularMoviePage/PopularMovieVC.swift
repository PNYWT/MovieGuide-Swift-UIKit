//
//  FirstMovieVC.swift
//  MovieGuide
//
//  Created by CallmeOni on 13/6/2566 BE.
//

import UIKit

class PopularMovieVC: UIViewController {
    
    private var moviePopularData:[PopularMovieModel] = []
    @IBOutlet weak var tbvMovie: UITableView!
    private let reuseIden = "MovieCell"
    
    @IBOutlet var vMovieBanner: MovieBanner!
    
    override func viewDidAppear(_ animated: Bool) {
        vMovieBanner.scrollingsetupTimmer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                self.moviePopularData = md_tmp.moviesModel
            }
            DispatchQueue.main.async {
                self.tbvMovie.reloadData()
            }
        }
        
        //Upcoming
        APIMovie.getUpcomingMovieData { responseData, error in
            if let md = responseData{
                DispatchQueue.main.async {
                    if self.vMovieBanner.isHidden{
                        self.vMovieBanner.isHidden = false
                        self.vMovieBanner.translatesAutoresizingMaskIntoConstraints = false
                        NSLayoutConstraint.activate([
                            self.vMovieBanner.heightAnchor.constraint(equalToConstant: 150)
                        ])
                    }
                    self.vMovieBanner.acceptDataBanner(md: md.upComingModel)
                    self.vMovieBanner.delegate = self
                }
            }else{
                self.vMovieBanner.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    self.vMovieBanner.heightAnchor.constraint(equalToConstant: 0)
                ])
                self.vMovieBanner.isHidden = true
                
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        vMovieBanner.timer?.invalidate()
        vMovieBanner.timer = nil
    }
}

extension PopularMovieVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviePopularData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIden, for: indexPath) as! PopularMovieViewCell
        let md:PopularMovieModel = moviePopularData[indexPath.row]
        cell.setupUI(title: md.title, releaseDate: md.year, rating: md.rateing, overview: md.overview, poster: md.posterImageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let md:PopularMovieModel = moviePopularData[indexPath.row]
        if let id = md.idMovie{
            let vc = DetailSelectVC.init()
            vc.idInput = id
            vc.type = .movie
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if moviePopularData.count > 0{
            return 30.0
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if moviePopularData.count > 0{
            let headerViewHeight = 30.0
            let headerView: UIView = UIView.init()
            headerView.frame = CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: headerViewHeight)
            headerView.backgroundColor = tableView.backgroundColor
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 40, height: headerView.frame.height))
            label.text = "Popular Movie"
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

extension PopularMovieVC: MovieBannerDelegate{
    func didselectIndex(movieId: Int) {
        let vc = DetailSelectVC.init()
        vc.type = .movie
        vc.idInput = movieId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
