//
//  SecondMovieVC.swift
//  MovieGuide
//
//  Created by CallmeOni on 13/6/2566 BE.
//

import UIKit

class SecondMovieVC: UIViewController {

    @IBOutlet weak var tbvMovieTopRate: UITableView!
    private let reuseIden = "MovieCell"
    private var movieTopRateData:[TopMovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTbv()
        fetchData()
    }
    
    private func setupTbv(){
        tbvMovieTopRate.register(UINib(nibName: "PopularMovieViewCell", bundle: nil), forCellReuseIdentifier: reuseIden)
        tbvMovieTopRate.delegate = self
        tbvMovieTopRate.dataSource = self
    }


    private func fetchData(){
        APIMovie.getTopMovieData { md, err in
            if let mdTmp = md{
                self.movieTopRateData = mdTmp.topMovieModel
                DispatchQueue.main.async {
                    self.tbvMovieTopRate.reloadData()
                }
            }else{
                
            }
        }
    }
}

extension SecondMovieVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTopRateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIden, for: indexPath) as! PopularMovieViewCell
        let md:TopMovieModel = movieTopRateData[indexPath.row]
        cell.setupUI(title: md.title, releaseDate: md.year, rating: md.rateing, overview: md.overview, poster: md.posterImageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let md:TopMovieModel = movieTopRateData[indexPath.row]
        if let id = md.idMovie{
            let vc = DetailSelectVC.init()
            vc.idInput = id
            vc.type = .movie
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if movieTopRateData.count > 0{
            return 30.0
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if movieTopRateData.count > 0{
            let headerViewHeight = 30.0
            let headerView: UIView = UIView.init()
            headerView.frame = CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: headerViewHeight)
            headerView.backgroundColor = tableView.backgroundColor
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 40, height: headerView.frame.height))
            label.text = "Top Rated Movie"
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
