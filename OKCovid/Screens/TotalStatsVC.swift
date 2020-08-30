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
    var countriesCollectionView: UICollectionView!
    
    enum Section { case main }

    var dataSource: UICollectionViewDiffableDataSource<Section, CountryData>!
    
    
    var countryData: [CountryData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
        downloadData(countryName: nil)
        
        getCountries(countryName: countryNames[3]["code"]!)
        configureDataSource()
//        downloadData(countryName: countryNames[0]["code"])
    }
    
    func getCountries(countryName: String) {
        NetworkManager.shared.downloadData(forCountry: countryName) { [weak self] result in
            guard let self = self else { return }
            //            self.dismissLoadingView()
            
            switch result {
            case.success(let countryData):
                self.updateUI(with: countryData)
            case.failure(let error):
                print(error)
            }
        }
        
    }
    
    func updateUI(with countryData: CountryData) {
        self.countryData.append(countryData)
        self.updateData(on: self.countryData)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CountryData>(collectionView: countriesCollectionView, cellProvider: { (collectionView, indexPath, countryData) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllTimeCell.reuseID, for: indexPath) as! AllTimeCell
            cell.countryNameLabel.text  = countryNames[3]["name"]
            cell.countryFlag.image      = UIImage(named: countryNames[3]["code"]!)
            cell.set(data: countryData)
            return cell
        })
    }
    
    func updateData(on countryData: [CountryData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CountryData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(countryData)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureCollectionView() {
        countriesCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.allCountriesFlowLayout())
        countriesCollectionView.register(AllTimeCell.self, forCellWithReuseIdentifier: AllTimeCell.reuseID)
        
        countriesCollectionView.backgroundColor     = .clear
        countriesCollectionView.isPagingEnabled     = true
        
        countriesCollectionView.delegate            = self
//        countriesCollectionView.dataSource          = self
    }
    
    private func configureUI() {
        view.addSubviews(headerView, countriesCollectionView)
        view.backgroundColor = .systemBackground
        
        let height = (view.frame.height / 5) - 5
        let width  = view.frame.width - 40
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.widthAnchor.constraint(equalToConstant: width),
            headerView.heightAnchor.constraint(equalToConstant: height),
            
            countriesCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 50),
            countriesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countriesCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width - 50),
            countriesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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

extension TotalStatsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: countriesCollectionView.frame.width, height: countriesCollectionView.frame.height)
    }
}

extension TotalStatsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}
