//
//  APIService.swift
//  RocketsAPI
//
//  Created by AutoMendes on 29/05/2025.
//

// RocketsAPI/APIService.swift

import Foundation

final class APIService {
    func fetchRockets(completion: @escaping ([Rocket]?) -> Void) {
        let urlString = "https://api.spacexdata.com/v4/rockets"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                DispatchQueue.main.async {
                    completion(nil)
                }
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let rockets = try decoder.decode([Rocket].self, from: data)
                    DispatchQueue.main.async {
                        completion(rockets)
                    }
                } catch {
                    print("Erro ao descodificar JSON: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
}
