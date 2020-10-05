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
    let headerView                  = UIView()
    var worldWideCases              = Double()
    
    var countryData: [CountryData]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
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
        
        let headerViewHeight    = view.frame.height / 4
        let width               = view.frame.width - 40
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.widthAnchor.constraint(equalToConstant: width),
            headerView.heightAnchor.constraint(equalToConstant: headerViewHeight),
            
            countriesCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: headerViewHeight / 3),
            countriesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countriesCollectionView.widthAnchor.constraint(equalToConstant: width),
            countriesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func getData() {
        getGlobalData()
        
        for i in 0...countryNames.count - 1 {
            getCountriesData(countryName: countryNames[i]["code"]!)
        }
    }
    
    
    func getGlobalData() {
        NetworkManager.shared.fetch(for: nil, ifDaily: false) { [weak self] (result: CountryData) in
            guard let self = self else { return }
            
            self.configureUIElements(with: result)
            self.worldWideCases = Double(result.cases)
        }
    }
    
    func configureUIElements(with countryData: CountryData) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            self.add(childVC: GlobalStatsHeaderVC(countryData: countryData), to: self.headerView)
        }
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    func getCountriesData(countryName: String) {
        NetworkManager.shared.fetch(for: countryName, ifDaily: false) { [weak self] (result: CountryData) in
            guard let self = self else { return }
            
            self.updateUI(with: result)
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
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CountryData>(collectionView: countriesCollectionView, cellProvider: { (collectionView, indexPath, countryData) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllTimeCell.reuseID, for: indexPath) as! AllTimeCell
            let cellHeight: CGFloat     = cell.contentView.frame.height
            
            cell.worldWideCases         = self.worldWideCases
            cell.countryFlag.image      = UIImage(named: countryNames[indexPath.row]["code"]!)
            cell.countryNameLabel.font  = UIFont.systemFont(ofSize: cellHeight / 15, weight: .bold)
            cell.countryNameLabel.text  = countryNames[indexPath.row]["name"]
            
            cell.configureElements(countryData: countryData)
            
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let country         = countryNames[indexPath.row]["code"]!
        let destVC          = DailyStatsVC()
        
        destVC.title        = countryNames[indexPath.row]["name"]! + " Daily Stats"
        destVC.downloadTimelineData(for: country)

        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true, completion: nil)
    }
}
