//
//  NYTimesArticleResponse.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation

struct NYTimesArticleResponse: Codable {
    let copyright: String
    let num_results: Int
    let results: [NYTimesArticle]
}
