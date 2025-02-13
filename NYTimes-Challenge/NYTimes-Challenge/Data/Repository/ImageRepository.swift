//
//  ImageRepositoryType.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation

final class ImageRepository: ImageRepositoryType {
    var apiClient: ApiClientType
    
    init(apiClient: ApiClientType = ApiClient.sharedInstance) {
        self.apiClient = apiClient
    }
    
    func getImageForArticle(imageURL: String, completion: @escaping (Result<Data?, APIError>) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        apiClient.fetchImage(with: url) { data in
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(data))
        }
    }
}
