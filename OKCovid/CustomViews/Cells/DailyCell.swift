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
    
    let casesTitleLbl       = OKTitleLabel(textAlignment: .left, fontSize: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor     = .systemBackground
        accessoryType       = .disclosureIndicator
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(countryData: Int) {
        configure()
        casesTitleLbl.text = "\(countryData)"
    }
    
    private func configure() {
        addSubviews(casesTitleLbl)
        NSLayoutConstraint.activate([
            casesTitleLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            casesTitleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            casesTitleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            casesTitleLbl.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
}
