//
//  AllTimeCell.swift
//  OKCovid
//
//  Created by Önder Koşar on 29.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class AllTimeCell: UICollectionViewCell {
    static let reuseID      = "allTimeCell"
    
    let countryFlag         = UIImageView()
    let countryNameLabel    = OKTitleLabel(textAlignment: .center, fontSize: 20)
    
    let titleStack          = UIStackView()
    let casesTitleLbl       = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let recoveredTitleLbl   = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let activeTitleLbl      = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let deathsTitleLbl      = OKTitleLabel(textAlignment: .left, fontSize: 20)
    
    let numStack            = UIStackView()
    let casesNumLbl         = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let recoveredNumLbl     = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let activeNumLbl        = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let deathsNumLbl        = OKTitleLabel(textAlignment: .right, fontSize: 20)
    
    var worldWideCases      = Double()
    let percentageLbl       = OKSecondaryTitleLabel(fontSize: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        
        configureElements()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureElements() {
        countryFlag.backgroundColor = .clear
        
        casesTitleLbl.text          = "Cases"
        recoveredTitleLbl.text      = "Recovered"
        activeTitleLbl.text         = "Active Cases"
        deathsTitleLbl.text         = "Deaths"
    }
    
    func set(data: CountryData) {
        if data.cases == 0 {
            casesNumLbl.text        = "N/A"
        } else {
            casesNumLbl.text        = "\(data.cases.numberFormat())"
        }
        
        if data.recovered == 0 {
            recoveredNumLbl.text    = "N/A"
            activeNumLbl.text       = "N/A"
        } else {
            recoveredNumLbl.text    = "\(data.recovered.numberFormat())"
            activeNumLbl.text       = "\((data.cases - data.recovered).numberFormat())"
        }
        
        if data.deaths == 0 {
            deathsNumLbl.text       = "N/A"
        } else {
            deathsNumLbl.text       = "\(data.deaths.numberFormat())"
        }
        
        percentageLbl.textAlignment = .right
        percentageLbl.text          = "\(((Double(data.cases) * 100) / worldWideCases).rounded(by: 1))" + "% of the global cases"
    }
    
    private func configureCollectionView() {
        addSubviews(countryFlag, countryNameLabel, titleStack, numStack, percentageLbl)
        titleStack.VStack(casesTitleLbl, recoveredTitleLbl, activeTitleLbl, deathsTitleLbl, spacing: 5, distribution: .fillEqually)
        numStack.VStack(casesNumLbl, recoveredNumLbl, activeNumLbl, deathsNumLbl, spacing: 5, distribution: .fillEqually)

        NSLayoutConstraint.activate([
            countryFlag.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30),
            countryFlag.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            countryFlag.widthAnchor.constraint(equalToConstant: 150),
            countryFlag.heightAnchor.constraint(equalToConstant: 150),
            
            countryNameLabel.topAnchor.constraint(equalTo: countryFlag.bottomAnchor, constant: 10),
            countryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            countryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            countryNameLabel.heightAnchor.constraint(equalToConstant: 22),
            
            
            titleStack.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 30),
            titleStack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleStack.widthAnchor.constraint(equalToConstant: 140),
            titleStack.heightAnchor.constraint(equalToConstant: 90),
            
            numStack.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 30),
            numStack.leadingAnchor.constraint(equalTo: titleStack.trailingAnchor, constant: 10),
            numStack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            numStack.heightAnchor.constraint(equalToConstant: 90),
            
            percentageLbl.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            percentageLbl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            percentageLbl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            percentageLbl.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
}
