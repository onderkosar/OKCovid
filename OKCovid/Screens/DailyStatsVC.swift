//
//  DailyStatsVC.swift
//  OKCovid
//
//  Created by Önder Koşar on 30.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit


class DailyStatsVC: UIViewController {
    enum Section { case main }
    var dataSource: UITableViewDiffableDataSource<Section, Int>!
    
    let dailyStatsTableView = UITableView()
    var casesData: [Int]    = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        
        downloadTimelineData(for: "tr")
        configureDataSource()
    }
    
    
    func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Daily Stats"
    }
    
    func configureTableView() {
        view.addSubview(dailyStatsTableView)
        
        dailyStatsTableView.frame         = view.bounds
        dailyStatsTableView.rowHeight     = 80
        dailyStatsTableView.delegate      = self
        
        dailyStatsTableView.register(DailyCell.self, forCellReuseIdentifier: DailyCell.reuseID)
    }
    
    
    private func downloadTimelineData(for country: String) {
        
        NetworkManager.shared.fetch(for: country, ifDaily: true) { [weak self] (result: CoronaCountryDataTimeline) in
            guard let self = self else { return }
            
            let casesDict = self.convertTimelineData(timeline: result.timeline.cases)
            let deathsDict = self.convertTimelineData(timeline: result.timeline.deaths)
            let timelineData = TimelineData(country: result.country, casesTimeline: casesDict, deathsTimeline: deathsDict)
            
            self.updateUI(with: timelineData)
        }
    }
    
    func convertTimelineData(timeline: [String: Int]) -> Array<(key: Date, value: Int)> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        
        var dateDictionary = [Date: Int]()
        
        for (key, value) in timeline {
            let date = dateFormatter.date(from: key)
            dateDictionary[date!] = value
        }
        let sortedList = dateDictionary.sorted { $0.0 < $1.0 }
        
        return sortedList
    }
    
    func updateUI(with countryData: TimelineData) {
        
        for i in 1...countryData.casesTimeline.count - 1 {
            self.casesData.append(countryData.casesTimeline[i].value)
        }
        
        updateData(on: self.casesData)
    }
    
    func updateData(on countryData: [Int]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(countryData)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Int>(tableView: dailyStatsTableView, cellProvider: { (tableView, indexPath, countryData) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyCell.reuseID, for: indexPath) as! DailyCell
            cell.set(countryData: self.casesData[indexPath.row])
            
            return cell
        })
    }
    
}

extension DailyStatsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casesData.count
    }
    
}
