//
//  ViewController.swift
//  MovieGuide
//
//  Created by Dev on 24/3/2566 BE.
//

import UIKit

class ViewController: UIViewController {
    let apiService = APIMovie.init()
    
    private var movieData:[MovieModel] = []
    @IBOutlet weak var tbvMovie: UITableView!
    private let reuseIden = "MovieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
        setupTbv()
    }
    
    private func setupTbv(){
        tbvMovie.register(UINib(nibName: "PopularMovieViewCell", bundle: nil), forCellReuseIdentifier: reuseIden)
        tbvMovie.delegate = self
        tbvMovie.dataSource = self
    }

    private func fetchData(){
        apiService.getPopularMoviesData { md, err in
            if let md_tmp = md{
                self.movieData = md_tmp.moviesModel
            }
            
            DispatchQueue.main.async {
                self.tbvMovie.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIden, for: indexPath) as! PopularMovieViewCell
        let md:MovieModel = movieData[indexPath.row]
        cell.setupUI(title: md.title, releaseDate: md.year, rating: md.rateing, overview: md.overview, poster: md.posterImageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

