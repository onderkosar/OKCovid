//
//  TotalStatsVC.swift
//  OKCovid
//
//  Created by Önder Koşar on 29.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class TotalStatsVC: UIViewController {
    
    let headerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        downloadData(countryName: nil)
    }
    
    
    private func configureUI() {
        view.addSubviews(headerView)
        view.backgroundColor = .systemBackground
        
        let height = (view.frame.height / 5) - 5
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    
    func downloadData(countryName: String?) {
            NetworkManager.shared.downloadData(forCountry: countryName) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let statistic):
                    self.configureUIElements(with: statistic)
//                    self.updateUI(with: statistic)
                case .failure(let error):
                    print(error)
    //                self.showErrorAlert(title: "Unable to retrieve data", message: error.rawValue)
    //                DispatchQueue.main.async {
    //                    self.finishedDownloading = true
    //                    self.refreshButton.layer.removeAllAnimations()
    //                    self.confirmedCasesNumberLabel.text = "0"
    //                    self.confirmedDeathsNumberLabel.text = "0"
    //                    self.confirmedRecoveriesNumberLabel.text = "0"
    //                }
                }
            }
        }
    
    func configureUIElements(with countryData: CountryData) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            self.add(childVC: TotalStatsHeaderVC(countryData: countryData), to: self.headerView)
        }
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
