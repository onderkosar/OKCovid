//
//  CountryData.swift
//  OKCovid
//
//  Created by Önder Koşar on 22.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

struct CountryData: Codable, Hashable {
    let country: String?
    let updated: Int
    let cases: Int
    let deaths: Int
    let recovered: Int
}
