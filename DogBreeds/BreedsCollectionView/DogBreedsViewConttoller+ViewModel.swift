//
//  ContentView+ViewModel.swift
//  Dogs
//
//  Created by Gary Hanson on 1/30/22.
//

import Foundation

extension DogBreedsViewController {
    @MainActor
    final class BreedViewModel: ObservableObject {
        
        @Published private(set) var breeds: [Breed] = []
        
        func fetchBreeds() async {
            do {
                var downloads: [Breed] = []
                
                let breedsDownload = try await NetworkService.fetch(urlString: "https://api.thedogapi.com/v1/breeds", myType: [DownloadBreedData].self)
                for breed in breedsDownload {
                    downloads.append(Breed(downloadedBreed: breed))
                }
                breeds = downloads
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
}

