//
//  NYTImesArticleViewModel.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 04/02/2025.
//

import Foundation
import Combine


final class NYTImesArticleViewModel: NSObject,  NYTImesArticleViewModelType {
    var title: String? { "Newyork Times" }
    private var repository: ArticleRepositoryType
    
    @Published private var items: [any NYTimeArticlesItemViewModelType]!
    @Published private var isLoading: Bool!
    @Published private var showError: String!
    private var articles: [NYTimesArticle] = []
    var itemsPublisher: Published<[NYTimeArticlesItemViewModelType]?>.Publisher{$items}
    var loadingPublisher: Published<Bool?>.Publisher{$isLoading}
        var errorPublisher: Published<String?>.Publisher {$showError}
    
   
    //MARK: - Initializer
    init(repository: ArticleRepositoryType) {
        self.repository = repository
    }
    //MARK: - Implementations
    
    func viewDidLoad() {
        self.getArticles()
    }
    func refresh(){
        self.getArticles()
    }
    
    func getModelForDetailController(indexPath: IndexPath) -> NYTimesArticle? {
        guard indexPath.row <= articles.count - 1 else { return nil }
        return articles[indexPath.row]
    }
}

extension NYTImesArticleViewModel {
    
    //MARK: - Private Functions
    
    private func getArticles() {
        isLoading = true
        repository.getArticles { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            self.handleResponse(result: result)
        }
    }
   
    private func handleResponse(result: Result<[NYTimesArticle], APIError>) {
        switch result {
        case .success(let articles): 
            self.articles = articles
            items = articles.compactMap({
                NYTimeArticlesItemViewModel(
                    data: $0,
                    identifier: ArticleTableViewCell.identifier,
                    imageRepo: ImageRepository(apiClient: ApiClient.sharedInstance))
            })
        case .failure(let error):
            showError = error.localizedDescription
        }
    }
}
