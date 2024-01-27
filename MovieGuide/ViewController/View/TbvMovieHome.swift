//
//  TbvMovieHome.swift
//  MovieGuide
//
//  Created by CallmeOni on 27/1/2567 BE.
//

import Foundation
import UIKit

enum TbvMovieSection : Int{
    case ContinueWatching = 2
    case TrendingTv = 0
    case Popular = 1
    case Upcoming = 4
    case TopRated = 3
}


class TbvMovieHome: UITableView {
    
    private lazy var headerView:HeaderTbvScrollMovie = {
        let headerView = HeaderTbvScrollMovie()
        return headerView
    }()
    
    let dataArray : [TbvMovieSection:String] = [.TrendingTv:"Tranding TV",
                                                .Popular:"Popular",
                                                .ContinueWatching:"Continue Watching",
                                                .Upcoming:"Upcoming Movies",
                                                .TopRated:"Top Rated"]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .clear
        self.dataSource = self
        self.delegate = self
        self.register(TbvPosterViewCell.self, forCellReuseIdentifier: TbvPosterViewCell.reuseIdenCell)
        self.setupHeaderViewHome()
    }
    
    private func setupHeaderViewHome(){
        let screenWidth = UIScreen.main.bounds.width
        let scaleFactor = screenWidth / 376
        let height = 477 * scaleFactor
        headerView = HeaderTbvScrollMovie(frame:CGRect(x: 0, y: 0, width: screenWidth, height: height))
        headerView.timeInterval = 5.0
        headerView.setupTimer()
        self.tableHeaderView = headerView
    }
    
    private func sectionTitle(for index: Int) -> String {
        guard let section = TbvMovieSection(rawValue: index) else {
            return ""
        }
        return dataArray[section] ?? ""
    }
}

extension TbvMovieHome: UITableViewDelegate, UITableViewDataSource {
    
    //Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    //Height Section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TbvPosterViewCell.reuseIdenCell, for: indexPath) as! TbvPosterViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        switch indexPath.section{
        case TbvMovieSection.ContinueWatching.rawValue:
            CustomService.getTrendingMovies{ result in
                switch result {
                case .success(let dataMovie):
                    cell.configure(with: dataMovie, hideShowPlayImg: false)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return cell
        case TbvMovieSection.TrendingTv.rawValue:
            CustomService.getTrendingTv { result in
                switch result {
                case .success(let dataMovie):
                    cell.configure(with: dataMovie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return cell
        case TbvMovieSection.Popular.rawValue:
            CustomService.getPopular { result in
                switch result {
                case .success(let dataMovie):
                    cell.configure(with: dataMovie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return cell
        case TbvMovieSection.Upcoming.rawValue:
            CustomService.getUpcomingMovies { result in
                switch result {
                case .success(let dataMovie):
                    cell.configure(with: dataMovie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return cell
        case TbvMovieSection.TopRated.rawValue:
            CustomService.getTopRated { result in
                switch result {
                case .success(let dataMovie):
                    cell.configure(with: dataMovie)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    //View header Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderSectionTbvView()
        headerView.configure(title: sectionTitle(for: section))
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
