//
//  TotalStatsHeaderVC.swift
//  OKCovid
//
//  Created by Önder Koşar on 29.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit


class TotalStatsHeaderVC: UIViewController {
    
    let headerTitle         = OKTitleLabel(textAlignment: .center, fontSize: 40)
    
    let casesTitleLbl       = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let recoveredTitleLbl   = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let activeTitleLbl      = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let deathsTitleLbl      = OKTitleLabel(textAlignment: .left, fontSize: 20)
    
    let casesNumLbl         = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let recoveredNumLbl     = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let activeNumLbl        = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let deathsNumLbl        = OKTitleLabel(textAlignment: .right, fontSize: 20)
    
    var countryData: CountryData!
    
    init(countryData: CountryData) {
        super.init(nibName: nil, bundle: nil)
        self.countryData = countryData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureElements()
        configureUI()
        
    }
    
    
    private func configureElements() {
        headerTitle.text        = "World-Wide Stats"
        
        casesTitleLbl.text      = "All-Time Cases"
        recoveredTitleLbl.text  = "Recovered Patients"
        activeTitleLbl.text     = "Active Cases"
        deathsTitleLbl.text     = "All-Time Deaths"
        
        casesNumLbl.text        = "\(countryData.cases.numberFormat())"
        recoveredNumLbl.text    = "\(countryData.recovered.numberFormat())"
        activeNumLbl.text       = "\((countryData.cases - countryData.recovered).numberFormat())"
        deathsNumLbl.text       = "\(countryData.deaths.numberFormat())"
    }
    
    private func configureUI() {
        view.addSubviews(headerTitle, casesTitleLbl, recoveredTitleLbl, activeTitleLbl, deathsTitleLbl, casesNumLbl, recoveredNumLbl, activeNumLbl, deathsNumLbl)
        
        view.backgroundColor    = .secondarySystemBackground
        view.layer.cornerRadius = 16
        view.layer.borderWidth  = 2
        view.layer.borderColor  = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerTitle.heightAnchor.constraint(equalToConstant: 32),
            
            casesTitleLbl.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 20),
            casesTitleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            casesTitleLbl.widthAnchor.constraint(equalToConstant: 190),
            casesTitleLbl.heightAnchor.constraint(equalToConstant: 22),
            
            recoveredTitleLbl.topAnchor.constraint(equalTo: casesTitleLbl.bottomAnchor, constant: 5),
            recoveredTitleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            recoveredTitleLbl.widthAnchor.constraint(equalToConstant: 190),
            recoveredTitleLbl.heightAnchor.constraint(equalToConstant: 22),
            
            activeTitleLbl.topAnchor.constraint(equalTo: recoveredTitleLbl.bottomAnchor, constant: 5),
            activeTitleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            activeTitleLbl.widthAnchor.constraint(equalToConstant: 190),
            activeTitleLbl.heightAnchor.constraint(equalToConstant: 22),
            
            deathsTitleLbl.topAnchor.constraint(equalTo: activeTitleLbl.bottomAnchor, constant: 5),
            deathsTitleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            deathsTitleLbl.widthAnchor.constraint(equalToConstant: 190),
            deathsTitleLbl.heightAnchor.constraint(equalToConstant: 22),
            
            casesNumLbl.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 20),
            casesNumLbl.leadingAnchor.constraint(equalTo: casesTitleLbl.trailingAnchor, constant: 10),
            casesNumLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            casesNumLbl.heightAnchor.constraint(equalToConstant: 22),
            
            recoveredNumLbl.topAnchor.constraint(equalTo: casesNumLbl.bottomAnchor, constant: 5),
            recoveredNumLbl.leadingAnchor.constraint(equalTo: recoveredTitleLbl.trailingAnchor, constant: 10),
            recoveredNumLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            recoveredNumLbl.heightAnchor.constraint(equalToConstant: 22),
            
            activeNumLbl.topAnchor.constraint(equalTo: recoveredNumLbl.bottomAnchor, constant: 5),
            activeNumLbl.leadingAnchor.constraint(equalTo: activeTitleLbl.trailingAnchor, constant: 10),
            activeNumLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            activeNumLbl.heightAnchor.constraint(equalToConstant: 22),
            
            deathsNumLbl.topAnchor.constraint(equalTo: activeNumLbl.bottomAnchor, constant: 5),
            deathsNumLbl.leadingAnchor.constraint(equalTo: deathsTitleLbl.trailingAnchor, constant: 10),
            deathsNumLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            deathsNumLbl.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}
