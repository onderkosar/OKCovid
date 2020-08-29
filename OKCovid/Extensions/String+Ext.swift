//
//  String+Ext.swift
//  OKCovid
//
//  Created by Önder Koşar on 26.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

extension Int {
    func numberFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value: self))!
    }
}
