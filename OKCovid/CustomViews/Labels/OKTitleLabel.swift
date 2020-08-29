//
//  OKTitleLabel.swift
//  OKCovid
//
//  Created by Önder Koşar on 29.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        configure()
        
        self.textAlignment  = textAlignment
        self.font           = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        adjustsFontSizeToFitWidth                   = true
        
        textColor           = .label
        lineBreakMode       = .byTruncatingTail
        minimumScaleFactor  = 0.8
    }
}
