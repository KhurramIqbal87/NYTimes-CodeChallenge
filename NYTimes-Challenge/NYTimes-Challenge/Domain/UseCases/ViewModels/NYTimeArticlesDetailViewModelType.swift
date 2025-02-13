//
//  NYTimeArticlesItemDetailViewModelType.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import Combine

protocol NYTimeArticlesDetailViewModelType: NYTimesBaseControllerViewModel, ViewLifeCycle {
    var articleTile: String { get }
    var date: String { get }
    var details: String { get }
    var url: String { get }
    var author: String { get }
    var copyRight: String { get }
    var imageDataPublisher: Published<Data?>.Publisher { get }
    var updateUI: VoidClosure? { get set }
}
