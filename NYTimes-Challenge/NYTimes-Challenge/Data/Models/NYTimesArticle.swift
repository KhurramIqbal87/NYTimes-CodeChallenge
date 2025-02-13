//
//  NYTimesArticle.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation

struct NYTimesArticle: Codable {
    let id: Int
    let title, abstract, published_date, section, byline, source, adx_keywords, url: String
    let media: [Media]
}
