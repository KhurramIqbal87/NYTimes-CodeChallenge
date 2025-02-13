//
//  ApiClient.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 10/02/2025.
//

import Foundation

protocol ApiClientType {
    func getData<Request: BaseRequest, Response: Decodable>  (request: Request, completion:@escaping ((_ response: Response?,_ error: APIError? )->Void))
    
    func fetchImage(with url: URL, completion: @escaping (Data?) -> Void)
}
