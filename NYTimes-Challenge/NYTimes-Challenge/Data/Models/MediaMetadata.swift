//
//  MediaMetadata.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation

struct MediaMetadata: Codable {
    let url: String
    let height, width: Float
    let format: MediaFormat
}
