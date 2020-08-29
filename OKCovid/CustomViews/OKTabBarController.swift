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
        viewControllers                 = [createTotalStatsNC()]
    }
    
    func createTotalStatsNC() -> UINavigationController {
        let totalStatsVC                = TotalStatsVC()
        
        totalStatsVC.title              = "Total Stats"
        totalStatsVC.tabBarItem         = UITabBarItem(title: "Total", image: SFSymbols.person, tag: 0)
        
        return UINavigationController(rootViewController: totalStatsVC)
    }
}
