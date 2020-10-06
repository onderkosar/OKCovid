//
//  OKTabBarController.swift
//  OKCovid
//
//  Created by Önder Koşar on 22.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit


class OKTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemOrange
        viewControllers                 = [createTotalStatsNC(), createSearchNC()]
    }
    
    func createTotalStatsNC() -> UINavigationController {
        let totalStatsVC                = TotalStatsVC()
        
        totalStatsVC.title              = "All-Time Total"
        totalStatsVC.tabBarItem         = UITabBarItem(title: "Total", image: SFSymbols.person, tag: 0)
        
        return UINavigationController(rootViewController: totalStatsVC)
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = CountryListVC()
        
        searchVC.title = "Countries Stats"
        searchVC.tabBarItem = UITabBarItem(title: "List", image: SFSymbols.allList, tag: 1)
        
        return UINavigationController(rootViewController: searchVC)
    }
}
