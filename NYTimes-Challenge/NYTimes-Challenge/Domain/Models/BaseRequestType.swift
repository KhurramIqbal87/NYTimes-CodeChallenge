//
//  BaseRequest.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation

protocol BaseRequest: Encodable {
    func getURLRequest() -> URLRequest?
}

