//
//  UpCommingViewController.swift
//  Netflix Clone
//
//  Created by boss1234 on 24/09/2022.
//

import UIKit

class UpCommingViewController: UIViewController {
    var titles:[Title] = [Title]()
    private let upcomingTable:UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier:TitleTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        fetchUpcomingMovie()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    private func fetchUpcomingMovie(){
        ApiCall.shared.getUpComingMovie{
           [weak self] results in
            switch results{
            case .success(let title):
                self?.titles = title
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }


}
extension UpCommingViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell()}
        let title = titles[indexPath.row].title ?? titles[indexPath.row].original_title ?? "unknown"
        cell.configure(with: TitleViewModel(titleName: title, postUrl: titles[indexPath.row].poster_path ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}
