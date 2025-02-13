//
//  MockImageRepository.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 13/02/2025.
//

import Foundation
import UIKit

final class MockImageRepository: ImageRepositoryType {
    var apiClient: ApiClientType
    
    init(apiClient: ApiClientType = ApiClient.sharedInstance) {
        self.apiClient = apiClient
    }
    func getImageForArticle(imageURL: String, completion: @escaping (Result<Data?, APIError>) -> Void) {
        let image = UIImage(named: "Dummy")
        completion(.success(image?.jpegData(compressionQuality: 1)))
    }
}
