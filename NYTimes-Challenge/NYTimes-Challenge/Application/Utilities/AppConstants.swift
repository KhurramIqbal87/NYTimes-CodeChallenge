//
//  AppConstants.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 10/02/2025.
//

import Foundation

struct Constants {
    static let baseURL = "http://api.nytimes.com/svc"
    static let apiKey = "OeKTfPKQmAmV0TflabiO2JyrCfcc1EQC"
    static let mostViewedSection = "/mostpopular/v2/mostviewed/"
    static let period = "/all-sections/%@.json"
    static let memoryCapacity = 100 * 1024 * 1024
    static let diskCapacity = 500 * 1024 * 1024
}
