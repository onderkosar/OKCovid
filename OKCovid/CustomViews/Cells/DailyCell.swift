//
//  DailyCell.swift
//  OKCovid
//
//  Created by Önder Koşar on 30.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class DailyCell: UITableViewCell {
    static let reuseID      = "dailyCell"
    
    let stackView           = UIStackView()
    
    let dateLbl             = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let casesStatsLbl       = OKSecondaryTitleLabel(fontSize: 20)
    let deathsStatsLbl      = OKSecondaryTitleLabel(fontSize: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor     = .systemBackground
        
        configureCell()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(countryData: DailyModel) {
        dateLbl.text        = "\(countryData.dDate.convertToMonthYearFormat())"
        casesStatsLbl.text  = "\(countryData.dCases.numberFormat())"
        deathsStatsLbl.text = "\(countryData.dDeaths.numberFormat())"
    }
    
    private func configureCell() {
        accessoryType       = .none
        selectionStyle      = .none
    }
    
    private func configureUI() {
        addSubviews(stackView)
        
        stackView.HStack(dateLbl, casesStatsLbl, deathsStatsLbl, spacing: 40, distribution: .fillEqually)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
}
