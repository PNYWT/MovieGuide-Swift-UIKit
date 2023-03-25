//
//  ViewController.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import UIKit

class HomeVC: UIViewController {
    private var movieData:[PopularMovieModel] = []
    @IBOutlet weak var tbvMovie: UITableView!
    private let reuseIden = "MovieCell"
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTbv()
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
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{

    
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
            let vc = MovieDetailVC.init()
            vc.movie_id = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

