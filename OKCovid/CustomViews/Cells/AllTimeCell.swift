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
    var countryNameLabel    = OKTitleLabel(textAlignment: .center, fontSize: 1)
    
    var statsStackView      = StatsStackView()
    
    var worldWideCases      = Double()
    let percentageLbl       = OKSecondaryTitleLabel(fontSize: 15)
    
    var cellHeight: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        cellHeight      = contentView.frame.height
        
        DispatchQueue.main.async {
            self.configureCollectionView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureElements(countryData: CountryData) {
        countryFlag.image               = UIImage(named: (countryData.country?.lowercased())!)
        
        countryNameLabel.font           = UIFont.systemFont(ofSize: cellHeight / 15, weight: .bold)
        countryNameLabel.text           = countryData.country
        
        percentageLbl.textAlignment     = .right
        percentageLbl.text              = "\(((Double(countryData.cases) * 100) / worldWideCases).rounded(by: 1))" + "% of the global cases"
        
        statsStackView.configureElements(countryData: countryData)
    }
    
    private func configureCollectionView() {
        addSubviews(countryFlag, countryNameLabel, statsStackView, percentageLbl)
        NSLayoutConstraint.activate([
            countryFlag.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            countryFlag.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            countryFlag.widthAnchor.constraint(equalToConstant: cellHeight / 3),
            countryFlag.heightAnchor.constraint(equalToConstant: cellHeight / 3),
            
            countryNameLabel.topAnchor.constraint(equalTo: countryFlag.bottomAnchor, constant: 10),
            countryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            countryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            countryNameLabel.heightAnchor.constraint(equalToConstant: (cellHeight / 15) + 1),
            
            percentageLbl.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            percentageLbl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            percentageLbl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            percentageLbl.heightAnchor.constraint(equalToConstant: 16),
            
            statsStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            statsStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            statsStackView.bottomAnchor.constraint(equalTo: percentageLbl.topAnchor, constant: -10),
            statsStackView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
}
