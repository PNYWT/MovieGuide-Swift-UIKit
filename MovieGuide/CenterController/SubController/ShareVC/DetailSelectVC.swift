//
//  MovieDetailVC.swift
//  MovieGuide
//
//  Created by Dev on 25/3/2566 BE.
//

import UIKit

enum typeData{
    case movie
    case tvSeries
}

class DetailSelectVC: UIViewController {
    
    var idInput = 0
    var type:typeData?
    private var movieIDData:MovieIDDetail?
    private var tvSeriesIDData:TvSeriesIDDetail?
    private let reuseIdenCltv = "GenresCell"
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lbTitleMovie: UILabel!
    @IBOutlet weak var lbRelease_date: UILabel!
    @IBOutlet weak var cltvGenres: UICollectionView!
    @IBOutlet weak var lbRuntimeMovie: UILabel!
    @IBOutlet weak var lbBudgetMovie: UILabel!
    @IBOutlet weak var lbTagline: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var imdbBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    private func fetchData(){
        if let typeInput = type{
            switch typeInput{
            case .movie:
                imdbBtn.isHidden = false
                APIMovie.getMovieDetail(idMovie: "\(idInput)") { md, err in
                    if let mdTmp = md{
                        self.movieIDData = mdTmp
                    }
                    
                    DispatchQueue.main.async {
                        self.setUI()
                    }
                }
                break
            case .tvSeries:
                imdbBtn.isHidden = true
                APITVSeries.getTVDetail(idTV: "\(idInput)") { responseData, err in
                    if let md = responseData{
                        self.tvSeriesIDData = md
                    }
                    DispatchQueue.main.async {
                        self.setUI()
                    }
                }
                break
            }
        }
        
    }
    
    private func setupCltv(){
        cltvGenres.dataSource = self
        cltvGenres.delegate = self
        cltvGenres.register(UINib(nibName: "GenresViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdenCltv)
        cltvGenres.showsHorizontalScrollIndicator = false
    }
    
    private func setUI(){
        self.setupCltv()
        
        if type == .movie{
            if let md = movieIDData {
                guard let posterString = md.posterImageURL else {return}
                
                guard let posterImageURL = URL(string: DomainPath.pathImg(posterString: posterString)) else {
                    self.imgMovie.image = UIImage.init(systemName: "")
                    return
                }
                self.imgMovie.getImageDataFrom(url: posterImageURL)
                
                lbTitleMovie.text = md.title
                
                lbRelease_date.text = convertDateFormater(md.release_date)
                
                if let runtime = md.runtime{
                    let runTimeFormatt = convertToTimeFormat(runtime)
                    lbRuntimeMovie.text = runTimeFormatt
                }
                
                lbBudgetMovie.text = "$ \(numberformatter(number: md.budget))"
                
                lbTagline.text = md.tagline
                
                if let overview = md.overview{
                    lbOverview.text = String.init(format: "Overview: %@", overview)
                }
                
                collectioViewSetup(sender: cltvGenres)
            }
        }else{
            if let md = tvSeriesIDData {
                guard let posterString = md.posterImageURL else {return}
                guard let posterImageURL = URL(string: DomainPath.pathImg(posterString: posterString)) else {
                    self.imgMovie.image = UIImage.init(systemName: "")
                    return
                }
                self.imgMovie.getImageDataFrom(url: posterImageURL)
                
                lbTitleMovie.text = md.title
                
                lbRelease_date.text = String(format: "First air :", convertDateFormater(md.first_air_date))
                
                if let seasons = md.number_of_seasons, let episodes = md.number_of_episodes{
                    lbRuntimeMovie.text = String(format: "%@ seasons, %@ episodes", "\(seasons)", "\(episodes)")
                }
                
                if let status = md.status{
                    lbBudgetMovie.text = String(format: "status : %@", status)
                }
                
                lbTagline.text = String(format: "Last air :", convertDateFormater(md.last_air_date))
                
                if let overview = md.overview{
                    lbOverview.text = String.init(format: "Overview: %@", overview)
                }
                
                collectioViewSetup(sender: cltvGenres)
            }
        }
    }
    
    func collectioViewSetup( sender: UICollectionView) {
        let xSpace:CGFloat = 5
        let layoutCollectionView = UICollectionViewFlowLayout()
        sender.backgroundColor = .clear
        
        switch sender{
        case cltvGenres:
            var itemRowCount: CGFloat = 0
            if type == .movie{
                itemRowCount = CGFloat((movieIDData?.genres.count) ?? 0)
            }else{
                itemRowCount = CGFloat((tvSeriesIDData?.genres.count) ?? 0)
            }
            var wItem:CGFloat = 120
            if itemRowCount < 4{
                wItem = (self.cltvGenres.frame.width/itemRowCount-1) - CGFloat(xSpace*(itemRowCount-1))
                cltvGenres.isScrollEnabled = false
            }
            let hItem:CGFloat = self.cltvGenres.frame.height
            layoutCollectionView.itemSize = CGSize.init(width: wItem, height: hItem)
            layoutCollectionView.minimumInteritemSpacing = CGFloat(xSpace)
            layoutCollectionView.minimumLineSpacing      = CGFloat(xSpace)
            layoutCollectionView.scrollDirection = .horizontal
            sender.collectionViewLayout = layoutCollectionView
            sender.contentInset = UIEdgeInsets(top: 0, left: CGFloat(xSpace), bottom: 0, right: CGFloat(xSpace))
            sender.reloadData()
        default:
            break
        }
    }
    
    @IBAction func gotoWeb(_ sender: Any) {
        let vc = WebVC.init()
        if let imdb = movieIDData?.imdb_id{
            vc.url = imdb
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DetailSelectVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == .movie{
            return movieIDData?.genres.count ?? 0
        }else{
            return tvSeriesIDData?.genres.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdenCltv, for: indexPath) as! GenresViewCell
        if type == .movie{
            if let md = movieIDData?.genres{
                cell.lbGenres.text = md[indexPath.row].name
                cell.lbGenres.adjustsFontSizeToFitWidth = true
            }
        }else{
            if let md = tvSeriesIDData?.genres{
                cell.lbGenres.text = md[indexPath.row].name
                cell.lbGenres.adjustsFontSizeToFitWidth = true
            }
        }
        return cell
    }
}
