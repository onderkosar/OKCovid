//
//  DataTypes+Ext.swift
//  OKCovid
//
//  Created by Önder Koşar on 30.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import Foundation

extension Int {
    func numberFormat() -> String {
        let formatter                       = NumberFormatter()
        
        formatter.numberStyle               = .decimal
        formatter.minimumFractionDigits     = 0
        formatter.groupingSeparator         = "."
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension Double {
    func rounded(by places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MMM d"
        
        return dateFormatter.string(from: self)
    }
}

extension String {
    func convertToDate() -> Date? {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.date(from: self)!
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
    
    func replaceSpace(with: String) -> String {
        let strWithoutSpace = self.replacingOccurrences(of: " ", with: "\(with)")
        
        return strWithoutSpace
    }
}
