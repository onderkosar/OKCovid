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
    var dataSource: UITableViewDiffableDataSource<Section, DailyModel>!
    
    let dailyStatsTableView         = UITableView()
    var dailyStats: [DailyModel]    = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureTableView()
        configureUI()
        configureDataSource()
    }
    
    
    private func configureTableView() {
        dailyStatsTableView.frame         = view.bounds
        dailyStatsTableView.rowHeight     = 40
        dailyStatsTableView.delegate      = self
    }
    
    private func configureUI() {
        view.addSubview(dailyStatsTableView)
        dailyStatsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        dailyStatsTableView.register(DailyCell.self, forCellReuseIdentifier: DailyCell.reuseID)
        NSLayoutConstraint.activate([
            dailyStatsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            dailyStatsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            dailyStatsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            dailyStatsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func downloadTimelineData(for country: String) {
        
        NetworkManager.shared.fetch(for: country, ifDaily: true) { [weak self] (result: CoronaCountryDataTimeline) in
            guard let self      = self else { return }
            
            let casesDict       = self.convertTimelineData(timeline: result.timeline.cases)
            let deathsDict      = self.convertTimelineData(timeline: result.timeline.deaths)
            let timelineData    = TimelineData(country: result.country, casesTimeline: casesDict, deathsTimeline: deathsDict)
            
            self.updateUI(with: timelineData)
        }
    }
    
    func convertTimelineData(timeline: [String: Int]) -> Array<(key: Date, value: Int)> {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MM/dd/yy"
        
        var dateDictionary          = [Date: Int]()
        
        for (key, value) in timeline {
            let date                = dateFormatter.date(from: key)
            dateDictionary[date!]   = value
        }
        let sortedList = dateDictionary.sorted { $0.0 < $1.0 }
        
        return sortedList
    }
    
    func updateUI(with timelineData: TimelineData) {
        for i in 1...timelineData.casesTimeline.count - 1 {
            self.dailyStats.append(.init(dDate: timelineData.casesTimeline[i].key, dCases: timelineData.casesTimeline[i].value - timelineData.casesTimeline[i-1].value, dDeaths: timelineData.deathsTimeline[i].value - timelineData.deathsTimeline[i-1].value))
        }
        
        updateData(on: self.dailyStats)
    }
    
    func updateData(on countryData: [DailyModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(countryData)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, DailyModel>(tableView: dailyStatsTableView, cellProvider: { (tableView, indexPath, countryData) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyCell.reuseID, for: indexPath) as! DailyCell
            cell.set(countryData: self.dailyStats[indexPath.row])
            
            return cell
        })
    }
    
}

extension DailyStatsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyStats.count
    }
    
}
