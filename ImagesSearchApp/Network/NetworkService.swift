//
//  NetworkService.swift
//  ImagesSearchApp
//
//  Created by Владимир Сеньков on 27.07.24.
//

import Foundation

final class NetworkService: ObservableObject {
    func request(urlString: String, completion: @escaping (SearchResponse?, Error?) -> Void ) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "or4baNIcVF9GM0KGNfiHdY4Qebl3ODELdmgqfSdf5hJ3JrXWSaU78bJa"]
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else { return }
                do {
                    let images = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(images, nil)
                } catch let jsonError {
                    completion(nil, jsonError)
                }
            }
        }.resume()
    }
}
