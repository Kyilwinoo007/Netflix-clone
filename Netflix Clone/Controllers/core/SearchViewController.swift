//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by boss1234 on 24/09/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var titles:[Title] = [Title]()
    private let discoverTable:UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier:TitleTableViewCell.identifier)
        return tableView
    }()

    let searchController :UISearchController = {
       let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or Tv show"
        controller.searchBar.searchBarStyle = .minimal
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(discoverTable)
        discoverTable.dataSource = self
        discoverTable.delegate = self
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .label
        fetchData()
        searchController.searchResultsUpdater = self
       
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    func fetchData(){
        ApiCall.shared.getDiscoverMovie{
            results in
            switch results{
            case.success(let title):
                self.titles = title
                DispatchQueue.main.async {
                    self.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension SearchViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        let titleName = titles[indexPath.row].original_title ?? titles[indexPath.row].title ?? "unknown"
        cell.configure(with:TitleViewModel(titleName: titleName, postUrl: titles[indexPath.row].poster_path ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
extension SearchViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
    
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 1,
              let searchResultController = searchController.searchResultsController as? SearchResultsViewController else{
            return
        }
        ApiCall.shared.search(with: query){
            results in
            DispatchQueue.main.async {
                switch results{
                case .success(let title):
                    searchResultController.titles = title
                    searchResultController.searchResultsCollectionView.reloadData()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    
}
