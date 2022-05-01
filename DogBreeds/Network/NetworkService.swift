//
//  NetworkService.swift
//
//  Created by Gary Hanson on 11/2/21.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case invalidJSON
    case invalidImageData
    case invalidImageForThumbnail
}

enum NetworkService {
    
    static func fetch<T: Decodable>(urlString: String, myType: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
          }
        
        let session = URLSession.shared

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidServerResponse
        }
        
        //print(String(bytes: data, encoding: String.Encoding.utf8))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            throw NetworkError.invalidJSON
        }
    }
}


