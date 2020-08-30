//
//  TotalStatsVC.swift
//  OKCovid
//
//  Created by Önder Koşar on 29.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class TotalStatsVC: UIViewController {
    enum Section { case main }
    var dataSource: UICollectionViewDiffableDataSource<Section, CountryData>!
    
    var countriesCollectionView: UICollectionView!
    let headerView = UIView()
    
    var worldWideCases = Double()
    var countryData: [CountryData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
        getData()
        configureDataSource()
    }
    
    
    func configureCollectionView() {
        countriesCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.allCountriesFlowLayout())
        countriesCollectionView.register(AllTimeCell.self, forCellWithReuseIdentifier: AllTimeCell.reuseID)
        
        countriesCollectionView.backgroundColor     = .clear
        
        countriesCollectionView.layer.cornerRadius  = 16
        countriesCollectionView.layer.borderWidth   = 2
        countriesCollectionView.layer.borderColor   = UIColor.white.cgColor
        
        countriesCollectionView.isPagingEnabled     = true
        
        countriesCollectionView.delegate            = self
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
    
    func getData() {
        getGlobalData(countryName: nil)
        
        for i in 0...10 {
            getCountriesData(countryName: countryNames[i]["code"]!)
        }
    }
    
    
    func getGlobalData(countryName: String?) {
        NetworkManager.shared.downloadData(forCountry: countryName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let statistic):
                self.configureUIElements(with: statistic)
                self.worldWideCases = Double(statistic.cases)
            case .failure(let error):
                print(error)
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
    
    
    func getCountriesData(countryName: String) {
        NetworkManager.shared.downloadData(forCountry: countryName) { [weak self] result in
            guard let self = self else { return }
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
    
    func updateData(on countryData: [CountryData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CountryData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(countryData)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CountryData>(collectionView: countriesCollectionView, cellProvider: { (collectionView, indexPath, countryData) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllTimeCell.reuseID, for: indexPath) as! AllTimeCell
            cell.worldWideCases         = self.worldWideCases
            cell.countryNameLabel.text  = countryNames[indexPath.row]["name"]
            cell.countryFlag.image      = UIImage(named: countryNames[indexPath.row]["code"]!)
            
            cell.set(data: self.countryData[indexPath.row])
            
            return cell
        })
    }
}


extension TotalStatsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: countriesCollectionView.frame.width, height: countriesCollectionView.frame.height)
    }
}

extension TotalStatsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryData.count
    }
}
