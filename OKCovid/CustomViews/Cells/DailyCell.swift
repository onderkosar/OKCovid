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
    let casesStack          = UIStackView()
    let deathsStack         = UIStackView()
    
    let dateLbl             = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let casesTitleLbl       = OKTitleLabel(textAlignment: .left, fontSize: 17)
    let casesStatsLbl       = OKSecondaryTitleLabel(fontSize: 17)
    let deathsTitleLbl      = OKTitleLabel(textAlignment: .left, fontSize: 17)
    let deathsStatsLbl      = OKSecondaryTitleLabel(fontSize: 17)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(countryData: DailyModel) {
        configureUI()
        
        dateLbl.text        = "\(countryData.dDate.convertToMonthYearFormat())"
        casesTitleLbl.text  = "cases: "
        casesStatsLbl.text  = "\(countryData.dCases)"
        deathsTitleLbl.text = "deaths: "
        deathsStatsLbl.text = "\(countryData.dDeaths)"
    }
    
    private func configureCell() {
        backgroundColor     = .systemBackground
        accessoryType       = .none
        selectionStyle      = .none
    }
    
    private func configureUI() {
        addSubviews(dateLbl, stackView)
        
        stackView.HStack(casesStack, deathsStack, spacing: 30, distribution: .equalSpacing)
        
        casesStack.HStack(casesTitleLbl, casesStatsLbl, spacing: 2, distribution: .fillEqually)
        deathsStack.HStack(deathsTitleLbl, deathsStatsLbl, spacing: 2, distribution: .fillEqually)
        
        NSLayoutConstraint.activate([
            dateLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLbl.widthAnchor.constraint(equalToConstant: 60),
            dateLbl.heightAnchor.constraint(equalToConstant: 22),
            
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: dateLbl.trailingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 22),
        ])
        
    }
}
