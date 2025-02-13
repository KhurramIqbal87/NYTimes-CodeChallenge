//
//  APIError.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 13/02/2025.
//

import Foundation

enum APIError: Error {
    case noInternet
    case badURL
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonDecodingError
    case unauthorizedAccess
    case serverNotRespond
    case technicalError
    case statusCode(Int)
    
    var localizedDescription: String {
        switch self {
        case .noInternet:
            return "Please Connect to internet"
        case .badURL:
            return "The URL is invalid."
        case .requestFailed:
            return "The network request failed."
        case .responseUnsuccessful:
            return "The server returned an unsuccessful response."
        case .invalidData:
            return "The received data is invalid."
        case .jsonDecodingError:
            return "Failed to decode the JSON response."
        case .statusCode(let code):
            return "Received an unexpected status code: \(code)"
        case .unauthorizedAccess:
            return "Bad URL or unauthorized "
        case .serverNotRespond:
            return "Server does not support the request"
        case .technicalError:
            return "Technical Error"
        }
    }
}
