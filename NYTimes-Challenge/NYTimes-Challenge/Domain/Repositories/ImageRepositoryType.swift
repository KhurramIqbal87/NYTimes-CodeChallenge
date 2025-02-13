//
//  ImageRepositoryType.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import Combine

protocol ImageRepositoryType {
    var apiClient: ApiClientType { get }
    
    func getImageForArticle(imageURL: String, completion:@escaping (Result<Data?, APIError>) -> Void)
}
