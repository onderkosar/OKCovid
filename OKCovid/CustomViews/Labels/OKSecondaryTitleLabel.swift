//
//  OKSecondaryTitleLabel.swift
//  OKCovid
//
//  Created by Önder Koşar on 30.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textAlignment               = .right
        adjustsFontSizeToFitWidth   = true
        textColor                   = .secondaryLabel
        minimumScaleFactor          = 0.8
        lineBreakMode               = .byTruncatingTail
    }
}
