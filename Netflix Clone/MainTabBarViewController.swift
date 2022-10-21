//
//  ViewController.swift
//  Netflix Clone
//
//  Created by boss1234 on 24/09/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let upcommingVC = UINavigationController(rootViewController: UpCommingViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let downloadVC = UINavigationController(rootViewController: DownloadViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        upcommingVC.tabBarItem.image = UIImage(systemName: "play.circle")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        
        homeVC.title = "Home"
        upcommingVC.title = "Up Comming"
        searchVC.title = "Search"
        downloadVC.title = "Download"
        
        tabBar.tintColor = .label
        setViewControllers([homeVC,upcommingVC,searchVC,downloadVC], animated: true)
    }


}

