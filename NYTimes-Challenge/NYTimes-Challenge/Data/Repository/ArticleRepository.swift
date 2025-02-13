//
//  ArticleRepositoryType.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import Combine

final class ArticleRepository: ArticleRepositoryType {
    private var apiClient: ApiClientType
    
    init(apiClient: ApiClientType) {
        self.apiClient = apiClient
    }
   
    func getArticles(completion: @escaping (Result<[NYTimesArticle], APIError>) -> Void) {
        let request = NYTimesArticleRequest(articlePeriod: .month)
        apiClient.getData(request: request) { (response: NYTimesArticleResponse?, error) in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(response?.results ?? []))
        }
    }
    
    
}
