//
//  Media.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation

struct Media: Codable {
    var type: MediaType
    var copyright: String
    var mediaMetaData: [MediaMetadata]?
    
    enum CodingKeys: String, CodingKey {
        case mediaMetaData = "media-metadata"
        case copyright
        case type
    }
}
