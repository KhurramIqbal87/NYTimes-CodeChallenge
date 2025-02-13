//
//  ApiClient.swift
//  NYTimes-Test
//
//  Created by Khurram Iqbal on 10/02/2025.
//

import Foundation
import UIKit

// I have use NSURLSession for our network Communication.

final class ApiClient: ApiClientType {
    
    let urlCache: URLCache
    
    //MARK: - Stored Properties
    static let sharedInstance = ApiClient.init()
    private let session = URLSession.shared
    
    private init() {
        urlCache = URLCache(
            memoryCapacity: Constants.memoryCapacity,
            diskCapacity: Constants.diskCapacity
        )
    }
    
    func getData<Request, Response>(request: Request, completion: @escaping ((Response?, APIError?) -> Void)) where Request : BaseRequest, Response : Decodable {
        if !Reachability.isConnectedToNetwork(){
            completion(nil,.noInternet)
            return
        }
        
        guard let urlRequest = request.getURLRequest() else {
            completion(nil, APIError.badURL)
            return
        }
        let task = self.session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let self = self else {
                completion(nil, APIError.technicalError)
                return
            }
            guard  error == nil  else{
                completion(nil, self.handleError(urlResponse: response))
                return
            }
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response: ", jsonString)
                }
                do {
                    let obj = try JSONDecoder().decode(Response.self, from: data)
                    completion(obj, nil)
                }  catch (_){
                    completion(nil, .jsonDecodingError)
                }
            } else{
                completion(nil, .invalidData)
            }
        }
        task.resume()
    }
    
    private func handleError( urlResponse: URLResponse?) -> APIError? {
        guard let httpURLResponse = urlResponse as? HTTPURLResponse else{ return .technicalError }
        
        let statusCode = httpURLResponse.statusCode
        if (401...499).contains(statusCode) {
            return APIError.unauthorizedAccess
        } else if (501...599).contains(statusCode)  {
            return APIError.serverNotRespond
        } else if !((201...599).contains(statusCode) ) {
            return APIError.statusCode(statusCode)
        } else {
            return .technicalError
        }
    }
    
    func fetchImage(with url: URL, completion: @escaping (Data?) -> Void) {
        // First check the in-memory cache
        if let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: url)) {
            completion(cachedResponse.data)
            return
        }
        if !Reachability.isConnectedToNetwork(){
            completion(nil)
            return
        }
        // If not in cache, download the image
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(nil)
                return
            }
            
            if let data,
               let response {
                // Cache the image for future use
                let cachedResponse = CachedURLResponse(response: response, data: data)
                self?.urlCache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
                completion(data)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
