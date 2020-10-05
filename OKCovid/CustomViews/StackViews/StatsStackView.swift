//
//  StackView1.swift
//  OKCovid
//
//  Created by Önder Koşar on 4.10.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class StatsStackView: UIStackView {
    
    let titleStack          = UIStackView()
    let numStack            = UIStackView()
    
    let casesTitleLbl       = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let recoveredTitleLbl   = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let activeTitleLbl      = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let deathsTitleLbl      = OKTitleLabel(textAlignment: .left, fontSize: 20)
    
    let casesNumLbl         = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let recoveredNumLbl     = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let activeNumLbl        = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let deathsNumLbl        = OKTitleLabel(textAlignment: .right, fontSize: 20)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.HStack(titleStack, numStack, distribution: .fillEqually)
        titleStack.VStack(casesTitleLbl, recoveredTitleLbl, activeTitleLbl, deathsTitleLbl, spacing: 1, distribution: .fillEqually)
        numStack.VStack(casesNumLbl, recoveredNumLbl, activeNumLbl, deathsNumLbl, spacing: 1, distribution: .fillEqually)
    }
    
    func configureElements(countryData: CountryData) {
        self.casesTitleLbl.text          = "Cases"
        self.recoveredTitleLbl.text      = "Recovered"
        self.activeTitleLbl.text         = "Active Cases"
        self.deathsTitleLbl.text         = "Deaths"

        if countryData.cases == 0 {
            self.casesNumLbl.text        = "N/A"
        } else {
            self.casesNumLbl.text        = "\(countryData.cases.numberFormat())"
        }
        
        if countryData.recovered == 0 {
            self.recoveredNumLbl.text    = "N/A"
            self.activeNumLbl.text       = "N/A"
        } else {
            self.recoveredNumLbl.text    = "\(countryData.recovered.numberFormat())"
            self.activeNumLbl.text       = "\((countryData.cases - countryData.recovered).numberFormat())"
        }
        
        if countryData.deaths == 0 {
            self.deathsNumLbl.text       = "N/A"
        } else {
            self.deathsNumLbl.text       = "\(countryData.deaths.numberFormat())"
        }
    }
}
