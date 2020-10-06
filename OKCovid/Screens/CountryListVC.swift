//
//  SearchVC.swift
//  OKCovid
//
//  Created by Önder Koşar on 6.10.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit


class CountryListVC: UIViewController {
    enum Section { case main }
    
    var dataSource: UITableViewDiffableDataSource<Section, CountryData>!
    var countriesTableView  = UITableView()
    
    let titleStack          = UIStackView()
    let countryLbl          = OKTitleLabel(textAlignment: .left, fontSize: 20)
    let casesLbl            = OKTitleLabel(textAlignment: .right, fontSize: 20)
    let deathsLbl           = OKTitleLabel(textAlignment: .right, fontSize: 20)
    
    var countryData: [CountryData]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureElements()
        configureUI()
        getData()
        configureDataSource()
    }
    
    
    private func configureElements() {
        countryLbl.text                 = "Country"
        casesLbl.text                   = "Cases"
        deathsLbl.text                  = "Deaths"
        
        countriesTableView.frame        = view.bounds
        countriesTableView.rowHeight    = 40
        countriesTableView.delegate     = self
        countriesTableView.showsVerticalScrollIndicator = false
    }
    
    private func configureUI() {
        view.addSubviews(countryLbl, titleStack, countriesTableView)
        titleStack.HStack(casesLbl, deathsLbl, distribution: .fillEqually)
        
        countriesTableView.register(CountryListCell.self, forCellReuseIdentifier: CountryListCell.reuseID)
        
        NSLayoutConstraint.activate([
            countryLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countryLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            countryLbl.widthAnchor.constraint(equalToConstant: 200),
            countryLbl.heightAnchor.constraint(equalToConstant: 40),
            
            titleStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleStack.leadingAnchor.constraint(equalTo: countryLbl.trailingAnchor),
            titleStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleStack.heightAnchor.constraint(equalToConstant: 40),
            
            countriesTableView.topAnchor.constraint(equalTo: countryLbl.bottomAnchor),
            countriesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            countriesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            countriesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func getData() {
        NetworkManager.shared.fetch(for: "", ifDaily: false) { [weak self] (result: [CountryData]) in
            guard let self      = self else { return }
            self.updateUI(with: result)
        }
    }
    
    func updateUI(with countryData: [CountryData]) {
        self.countryData.append(contentsOf: countryData)
        updateData(on: self.countryData)
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
        dataSource = UITableViewDiffableDataSource<Section, CountryData>(tableView: countriesTableView, cellProvider: { (tableView, indexPath, countryData) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CountryListCell.reuseID, for: indexPath) as! CountryListCell
            cell.configureElements(countryData: countryData)
            
            return cell
        })
    }
    
}

extension CountryListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryData.count
    }
    
}
