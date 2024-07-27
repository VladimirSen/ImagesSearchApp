//
//  ImagesSearchModel.swift
//  ImagesSearchApp
//
//  Created by Владимир Сеньков on 27.07.24.
//

struct SearchResponse: Codable {
    let photos: [Photo]
}

struct Photo: Codable, Identifiable {
    var id: Int
    let photographer: String
    let src: Src
    let alt: String
}

struct Src: Codable {
    let large2X, small, tiny: String

    enum CodingKeys: String, CodingKey {
        case large2X = "large2x"
        case small, tiny
    }
}
