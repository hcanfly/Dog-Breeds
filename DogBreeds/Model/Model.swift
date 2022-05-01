//
//  Model.swift
//  Dogs
//
//  Created by Gary Hanson on 1/30/22.
//

import Foundation

// used in app
struct Breed: Identifiable {
    let id: Int
    let name: String
    let breedGroup: String
    let bredFor: String
    let temperment: String
    let lifeSpan: String
    let height: String
    let weight: String
    let imageURL: String
    
    init(downloadedBreed: DownloadBreedData) {
        id = downloadedBreed.id
        name = downloadedBreed.name
        breedGroup = downloadedBreed.breedGroup ?? "Unkown"
        bredFor = downloadedBreed.bredFor ?? "Unknown"
        temperment = downloadedBreed.temperament ?? "Unknown"
        lifeSpan = downloadedBreed.lifeSpan
        height = downloadedBreed.height.imperial
        weight = downloadedBreed.weight.imperial
        imageURL = downloadedBreed.image.url
    }
    
    init(id: Int, name: String, breedGroup: String, bredFor: String, temperment: String, lifeSpan: String, height: String, weight: String, imageURL: String) {
        self.id = id
        self.name = name
        self.breedGroup = breedGroup
        self.bredFor = bredFor
        self.temperment = temperment
        self.lifeSpan = lifeSpan
        self.height = height
        self.weight = weight
        self.imageURL = imageURL
    }
}

// for use in downloading and converting JSON
struct DownloadImageData: Decodable {
    let url: String
}

struct DownloadImperialData: Decodable {
    let imperial: String
}

struct DownloadBreedData: Decodable {
    let id: Int
    let name: String
    let temperament: String?
    let breedGroup: String?
    let bredFor: String?
    let lifeSpan: String
    let height: DownloadImperialData
    let weight: DownloadImperialData
    let image: DownloadImageData
}
