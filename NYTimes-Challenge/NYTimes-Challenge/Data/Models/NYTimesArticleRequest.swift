//
//  NYTimesArticleRequest.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation


struct NYTimesArticleRequest: BaseRequest, Encodable {
    private let articlePeriod: ArticlePeriods
    
    private var path: String {
        Constants.baseURL + Constants.mostViewedSection + String(format: Constants.period, "\(articlePeriod.rawValue)")
    }
    private var queryParams: [String: String] {
        ["api-key" : Constants.apiKey]
    }
   
    init(articlePeriod: ArticlePeriods) {
        self.articlePeriod = articlePeriod
    }
    
    func getURLRequest() -> URLRequest? {
        guard let url = URL(string: path) else { return nil }
        var urlComponent = URLComponents.init(string: path)
        urlComponent?.queryItems = queryParams.compactMap({ URLQueryItem.init(name: $0.key, value: $0.value )
        })
        var urlRequest = URLRequest.init(url: urlComponent?.url ?? url)
        urlRequest.httpMethod = HttpMethod.get.rawValue
        return urlRequest
    }
}

//MARK: - EncodedKeys

extension NYTimesArticleRequest{
    enum CodingKeys: CodingKey { }
}

