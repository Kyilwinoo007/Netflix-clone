//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by boss1234 on 24/09/2022.
//

import UIKit
enum Sections:Int {
    case TrendingMovie = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    let sectionsTitle :[String] = ["Trending Movies","Trending TV","Popular","Upcoming Movies","Top rated"]
    let homeViewtable :UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeViewtable)
        homeViewtable.delegate = self
        homeViewtable.dataSource = self
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeViewtable.tableHeaderView = headerView
        
        configureNavbar()
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeViewtable.frame = view.bounds
    }
    private func configureNavbar(){
        
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 50)))
        let  btn = UIButton(frame: CGRect(x: 0, y: 2 , width: 30, height: 40))
        btn.setImage(UIImage(named: "netflixLogo")?.withRenderingMode(.alwaysTemplate), for: .normal)
//        btn.addTarget(self, action: #selector(), for: .touchUpInside)
        btn.tintColor = .red
        view.addSubview(btn)

        let uibarbtnItem = UIBarButtonItem(customView: view)
        navigationItem.leftBarButtonItem = uibarbtnItem
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .label
    }

//    func fetchData(){
//        ApiCall.shared.getTrendingMovie(completion:{
//            results in
//            switch results{
//            case.success(let movies):
//                print("trending movies")
//                print(movies)
//            case.failure(let error):
//                print(error)
//            }
//        }
//        )
//        ApiCall.shared.getUpComingMovie(completion: {
//            results in
//            switch results{
//            case.success(let movies):
//                print("upcomming movie")
//                print(movies)
//            case.failure(let error):
//                print(error)
//            }
//        })
//        ApiCall.shared.getPopularMovie(completion: {
//            results in
//            switch results{
//            case.success(let movies):
//                print("popular movie")
//                print(movies)
//            case.failure(let error):
//                print(error)
//            }
//        })
//        ApiCall.shared.getTrendingTvs(completion: {
//            results in
//            switch results{
//            case .success(let tvs):
//                print("trending tvs")
//                print(tvs)
//            case .failure(let error):
//                print(error)
//            }
//
//        })
//        ApiCall.shared.getTopRated(completion: {
//            results in
//            switch results{
//            case .success(let movies):
//                print("top rated")
//                print(movies)
//            case .failure(let error):
//                print(error)
//            }
//        })
//    }
    
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.section{
        case Sections.TrendingMovie.rawValue:
            ApiCall.shared.getTrendingMovie{
            results in
            switch results {
            case .success(let title):
                cell.configure(with: title)
            case .failure(let error):
                print(error)
            }
            }
        case Sections.TrendingTv.rawValue:
            ApiCall.shared.getTrendingTvs{
                result in
                switch result{
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.Popular.rawValue:
            ApiCall.shared.getPopularMovie{
                result in
                switch result{
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.Upcoming.rawValue:
            ApiCall.shared.getUpComingMovie{
                result in
                switch result{
                case.success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.TopRated.rawValue:
            ApiCall.shared.getTopRated{
                result in
                switch result{
                case .success(let title):
                    cell.configure(with: title)
                case .failure(let error):
                    print(error)
                }
            }
        default:
            print("Something went wrong")
            return UITableViewCell()
        }
        
        
       return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitle[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else{return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView :UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0 , -offset))
    }

    
}
