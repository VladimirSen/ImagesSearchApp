//
//  ImagesSearchViewModel.swift
//  ImagesSearchApp
//
//  Created by Владимир Сеньков on 27.07.24.
//

import Foundation

final class ViewModel: ObservableObject {
    @Published var showingAlert = false
    @Published var searchResponse: SearchResponse?
    private var service = NetworkService()
    
    func searchImages(keyWord: String) {
        let urlString = "https://api.pexels.com/v1/search?query=\(keyWord)&per_page=80"
        service.request(urlString: urlString) { [weak self] (searchResponse, error) in
            if error != nil {
                self?.showingAlert = true
            }
            self?.searchResponse = searchResponse
        }
    }
}
