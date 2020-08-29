//
//  NetworkManager.swift
//  OKCovid
//
//  Created by Önder Koşar on 22.08.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL = "https://disease.sh/v2/"
    
    private init() {}
    
    func downloadData(forCountry country: String?, completion: @escaping (Result<CountryData, OKError>) -> ()) {
        var endpoint: String
        
        if let country = country {
            endpoint = baseURL + "countries/\(country)"
        }
        else {
            endpoint = baseURL + "all"
        }

        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error)
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let covidData = try JSONDecoder().decode(CountryData.self, from: data)
                completion(.success(covidData))
            }
            catch {
                print(error)
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
