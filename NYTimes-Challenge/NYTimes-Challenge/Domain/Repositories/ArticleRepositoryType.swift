//
//  ArticleRepositoryType.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import Combine

//MARK: - Repository
protocol ArticleRepositoryType {
    func getArticles(completion: @escaping (Result<[NYTimesArticle], APIError>) -> Void)
}
