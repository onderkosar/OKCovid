//
//  UIHelper.swift
//  OKCovid
//
//  Created by Önder Koşar on 30.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

enum UIHelper {
    
    static func allCountriesFlowLayout() -> UICollectionViewFlowLayout {
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.scrollDirection      = .horizontal
        flowLayout.minimumLineSpacing   = 0
        
        return flowLayout
    }
    
}
