//
//  ImageLoader.swift
//  ImagesSearchApp
//
//  Created by Владимир Сеньков on 27.07.24.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil

    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }.resume()
    }
}
