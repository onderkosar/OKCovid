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
    let cases: Int
    let deaths: Int
    let recovered: Int
}

struct CoronaCountryDataTimeline: Codable, Hashable {
    let country: String
    let timeline: Timeline
}


struct Timeline: Codable, Hashable {
    let cases: [String: Int]
    let deaths: [String: Int]
}


struct TimelineData {
    var country: String
    var casesTimeline: Array<(key: Date, value: Int)>
    var deathsTimeline: Array<(key: Date, value: Int)>
}
