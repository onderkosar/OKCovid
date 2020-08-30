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
    
    let casesTitleLbl       = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let recoveredTitleLbl   = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let activeTitleLbl      = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let deathsTitleLbl      = OKTitleLabel(textAlignment: .left, fontSize: 20)
    
    let casesNumLbl         = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let recoveredNumLbl     = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let activeNumLbl        = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let deathsNumLbl        = OKTitleLabel(textAlignment: .right, fontSize: 20)
    
    var worldWideCases      = Double()
    let percentageLbl       = OKSecondaryTitleLabel(fontSize: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        addSubviews(countryFlag, countryNameLabel, casesTitleLbl, recoveredTitleLbl, activeTitleLbl, deathsTitleLbl, casesNumLbl, recoveredNumLbl, activeNumLbl, deathsNumLbl, percentageLbl)
        backgroundColor = .secondarySystemBackground

        NSLayoutConstraint.activate([
            countryFlag.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30),
            countryFlag.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            countryFlag.widthAnchor.constraint(equalToConstant: 150),
            countryFlag.heightAnchor.constraint(equalToConstant: 150),
            
            countryNameLabel.topAnchor.constraint(equalTo: countryFlag.bottomAnchor, constant: 10),
            countryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            countryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            countryNameLabel.heightAnchor.constraint(equalToConstant: 22),
            
            casesTitleLbl.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 30),
            casesTitleLbl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            casesTitleLbl.widthAnchor.constraint(equalToConstant: 140),
            casesTitleLbl.heightAnchor.constraint(equalToConstant: 22),
            
            recoveredTitleLbl.topAnchor.constraint(equalTo: casesTitleLbl.bottomAnchor, constant: 5),
            recoveredTitleLbl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            recoveredTitleLbl.widthAnchor.constraint(equalToConstant: 140),
            recoveredTitleLbl.heightAnchor.constraint(equalToConstant: 22),
            
            activeTitleLbl.topAnchor.constraint(equalTo: recoveredTitleLbl.bottomAnchor, constant: 5),
            activeTitleLbl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            activeTitleLbl.widthAnchor.constraint(equalToConstant: 140),
            activeTitleLbl.heightAnchor.constraint(equalToConstant: 22),
            
            deathsTitleLbl.topAnchor.constraint(equalTo: activeTitleLbl.bottomAnchor, constant: 5),
            deathsTitleLbl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            deathsTitleLbl.widthAnchor.constraint(equalToConstant: 140),
            deathsTitleLbl.heightAnchor.constraint(equalToConstant: 22),
            
            casesNumLbl.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 30),
            casesNumLbl.leadingAnchor.constraint(equalTo: casesTitleLbl.trailingAnchor, constant: 10),
            casesNumLbl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            casesNumLbl.heightAnchor.constraint(equalToConstant: 22),
            
            recoveredNumLbl.topAnchor.constraint(equalTo: casesNumLbl.bottomAnchor, constant: 5),
            recoveredNumLbl.leadingAnchor.constraint(equalTo: recoveredTitleLbl.trailingAnchor, constant: 10),
            recoveredNumLbl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            recoveredNumLbl.heightAnchor.constraint(equalToConstant: 22),
            
            activeNumLbl.topAnchor.constraint(equalTo: recoveredNumLbl.bottomAnchor, constant: 5),
            activeNumLbl.leadingAnchor.constraint(equalTo: activeTitleLbl.trailingAnchor, constant: 10),
            activeNumLbl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            activeNumLbl.heightAnchor.constraint(equalToConstant: 22),
            
            deathsNumLbl.topAnchor.constraint(equalTo: activeNumLbl.bottomAnchor, constant: 5),
            deathsNumLbl.leadingAnchor.constraint(equalTo: deathsTitleLbl.trailingAnchor, constant: 10),
            deathsNumLbl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            deathsNumLbl.heightAnchor.constraint(equalToConstant: 22),
            
            percentageLbl.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            percentageLbl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            percentageLbl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            percentageLbl.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
}
