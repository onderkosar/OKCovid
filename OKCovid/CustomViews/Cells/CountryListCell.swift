//
//  CountriesCell.swift
//  OKCovid
//
//  Created by Önder Koşar on 6.10.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class CountryListCell: UITableViewCell {
    static let reuseID      = "countryListCell"
    
    let stackView           = UIStackView()
    
    let countryLbl          = OKSecondaryTitleLabel(fontSize: 15)
    let casesStatsLbl       = OKSecondaryTitleLabel(fontSize: 15)
    let deathsStatsLbl      = OKSecondaryTitleLabel(fontSize: 15)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor     = .systemBackground
        
        configureCell()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureElements(countryData: CountryData) {
        countryLbl.textAlignment    = .left
        countryLbl.text             = countryData.country
        casesStatsLbl.text          = "\(countryData.cases.numberFormat())"
        deathsStatsLbl.text         = "\(countryData.deaths.numberFormat())"
    }
    
    private func configureCell() {
        accessoryType       = .none
        selectionStyle      = .none
    }
    
    private func configureUI() {
        addSubviews(countryLbl, stackView)
        
        stackView.HStack(casesStatsLbl, deathsStatsLbl, distribution: .fillEqually)

        NSLayoutConstraint.activate([
            countryLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countryLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            countryLbl.widthAnchor.constraint(equalToConstant: 200),
            countryLbl.heightAnchor.constraint(equalToConstant: 22),
            
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: countryLbl.trailingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
}
