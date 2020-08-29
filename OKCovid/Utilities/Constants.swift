//
//  Constants.swift
//  OKCovid
//
//  Created by Önder Koşar on 22.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

let countryNames = [["code": "usa", "name": "United States of America"],
                    ["code": "uk",  "name": "United Kingdom"],
                    ["code": "deu",  "name": "Germany"],
                    ["code": "ita",  "name": "Italy"],
                    ["code": "esp",  "name": "Spain"],
                    ["code": "tr",  "name": "Turkey"],
                    ["code": "au",  "name": "Australia"],
                    ["code": "bra",  "name": "Brazil"],
                    ["code": "bel",  "name": "Belgium"],
                    ["code": "can",  "name": "Canada"],
                    ["code": "fr",  "name": "France"]
]

enum SFSymbols {
    
    static let global   = UIImage(systemName: "globe")
    static let person   = UIImage(systemName: "person.3")
}

enum Countries {
    static let usa      = "USA"
    static let uk       = "UK"
    static let ger      = "Germany"
    static let ita      = "Italy"
    static let tr       = "Turkey"
}
