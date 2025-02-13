//
//  NYTimeArticlesItemViewModelType.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import Combine

// MARK: - ViewLife Cycle protocol
protocol ViewLifeCycle {
    func loadView()
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

extension ViewLifeCycle {
    func loadView() { }
    func viewDidLoad() { }
    func viewWillAppear() { }
    func viewWillDisappear() { }
}
// MARK: - Article View Model
protocol NYTimesBaseControllerViewModel {
    var title: String? { get }
}

protocol NYTImesArticleViewModelType: ViewLifeCycle, NYTimesBaseControllerViewModel {
    var itemsPublisher: Published<[NYTimeArticlesItemViewModelType]?>.Publisher { get }
    var loadingPublisher: Published<Bool?>.Publisher { get }
    var errorPublisher: Published<String?>.Publisher { get }
    
    func didSelectArticle(at indexPath: IndexPath)
    func tableViewDidScroll(at indexPath: IndexPath)
    func getModelForDetailController(indexPath: IndexPath) -> NYTimesArticle?
    func refresh()
}

extension NYTImesArticleViewModelType {
    func didSelectArticle(at indexPath: IndexPath) { }
    func tableViewDidScroll(at indexPath: IndexPath) { }
}
