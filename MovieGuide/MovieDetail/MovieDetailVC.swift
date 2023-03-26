//
//  MovieDetailVC.swift
//  MovieGuide
//
//  Created by Dev on 25/3/2566 BE.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    var movie_id = 0
    private var movieIDData:MovieIDDataModel?
    private let reuseIdenCltv = "GenresCell"
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lbTitleMovie: UILabel!
    @IBOutlet weak var lbRelease_date: UILabel!
    @IBOutlet weak var cltvGenres: UICollectionView!
    @IBOutlet weak var lbRuntimeMovie: UILabel!
    @IBOutlet weak var lbBudgetMovie: UILabel!
    @IBOutlet weak var lbTagline: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func fetchData(){
        APIMovie.getMovieIDData(idMovie: "\(movie_id)") { md, err in
            if let mdTmp = md{
                self.movieIDData = mdTmp
            }
            
            DispatchQueue.main.async {
                self.setUI()
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
        if let md = movieIDData {
            guard let posterString = md.posterImageURL else {return}
            
            guard let posterImageURL = URL(string: DomainPath.pathImg(posterString: posterString)) else {
                self.imgMovie.image = UIImage.init(systemName: "")
                return
            }
            self.imgMovie.image = nil
            
            getImageDataFrom(url: posterImageURL)
            
            lbTitleMovie.text = md.title
            
            lbRelease_date.text = convertDateFormater(md.release_date)
            
            lbRuntimeMovie.text = "Runtime: \(md.runtime ?? 0)"
            
            lbBudgetMovie.text = "$ \(numberformatter(number: md.budget))"
            
            lbTagline.text = md.tagline
            
            lbOverview.text = String.init(format: "Overview: %@", md.overview!)
            
            collectioViewSetup(sender: cltvGenres)
        }
    }
    
    func collectioViewSetup( sender: UICollectionView) {
        let xSpace:CGFloat = 5
        let layoutCollectionView = UICollectionViewFlowLayout()
        sender.backgroundColor = .clear
        
        switch sender{
        case cltvGenres:
            let itemRowCount: CGFloat = CGFloat((movieIDData?.genres.count) ?? 0)
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
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty Data")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.imgMovie.image = image
                }
            }
        }.resume()
    }
    
    @IBAction func gotoWeb(_ sender: Any) {
        let vc = WebVC.init()
        if let imdb = movieIDData?.imdb_id{
            vc.url = imdb
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MovieDetailVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieIDData?.genres.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdenCltv, for: indexPath) as! GenresViewCell
        if let md = movieIDData?.genres{
            cell.lbGenres.text = md[indexPath.row].name
            cell.lbGenres.adjustsFontSizeToFitWidth = true
        }
        return cell
    }
}
