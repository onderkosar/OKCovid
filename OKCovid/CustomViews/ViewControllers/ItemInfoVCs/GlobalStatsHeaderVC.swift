//
//  TotalStatsHeaderVC.swift
//  OKCovid
//
//  Created by Önder Koşar on 29.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit


class GlobalStatsHeaderVC: UIViewController {
    
    var headerTitle         = OKTitleLabel()
    var headerStackView     = StatsStackView()
    var titleHeight: CGFloat!
    
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
        configure()
        configureUI()
        
    }
    
    
    private func configure() {
        headerStackView.configureElements(countryData: countryData)
        
        titleHeight             = view.frame.height / 24
        
        headerTitle             = OKTitleLabel(textAlignment: .center, fontSize: titleHeight - 1)
        headerTitle.text        = "World-Wide Stats"
        
        view.backgroundColor    = .secondarySystemBackground
        view.layer.cornerRadius = 16
        view.layer.borderWidth  = 2
        view.layer.borderColor  = UIColor.white.cgColor
    }
    
    private func configureUI() {
        view.addSubviews(headerTitle, headerStackView)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            headerTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerTitle.heightAnchor.constraint(equalToConstant: titleHeight),
            
            headerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            headerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            headerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            headerStackView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}
