//
//  NYTimeArticlesItemViewModelType.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import Combine

protocol NYTimeArticlesItemViewModelType: Hashable {
    var id: Int { get }
    var title: String { get }
    var date: String { get }
    var details: String { get }
    var identifier: String { get }
    var author: String { get }
    var copyRight: String { get }
    var section: String { get }
    var imageDownloaded: ((_ data: Data, _ id: Int) -> Void)? { get set}
    func getImageData() -> Data?
}

extension NYTimeArticlesItemViewModelType {
    var section: String { return "New Articles" }
}
