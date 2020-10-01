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
    
    func fetch<Model: Decodable>(for country: String?, ifDaily: Bool, completed: @escaping (Model) -> ()) {
        
        var endpoint: String
        var status: String
        
        if ifDaily {
            status = "historical"
        } else {
            status = "countries"
        }
        
        if let country = country {
            endpoint = baseURL + "\(status)/\(country.replaceSpace(with: "-"))"
        }
        else {
            endpoint = baseURL + "all"
        }
        
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let obj  = try decoder.decode(Model.self, from: data)
                completed(obj)
            }  catch let err {
                print(err)
            }
        }
        
        task.resume()
    }
}
