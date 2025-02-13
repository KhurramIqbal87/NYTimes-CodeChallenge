//
//  NYTimesArticleContainer.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 11/02/2025.
//

import Foundation

struct NYTimesArticleContainer {
    func getArticlesViewController(coordinator: NYTimesArticleCoordinatorType) -> (NYTimesViewController<NYTImesArticleViewModel>, NYTImesArticleViewModel) {
        
        let viewModel = getArticlesViewModel()
        let controller = NYTimesViewController(
            viewModel,
            tableViewAdapter: getTableViewAdapter(),
            coordinator: coordinator
        )
        return (controller, viewModel)
    }
    
    func getArticlesViewModel() -> NYTImesArticleViewModel{
        NYTImesArticleViewModel(repository: getArticlesRepository())
    }
    
    func getArticlesRepository() -> ArticleRepositoryType {
        ArticleRepository(apiClient: ApiClient.sharedInstance)
    }
    
    func getTableViewAdapter() -> ArtilesTableViewAdapter<ArticleTableViewCell, NYTimeArticlesItemViewModel> {
         ArtilesTableViewAdapter<ArticleTableViewCell, NYTimeArticlesItemViewModel>(data: [[]], tableView: nil)
    }
    
    func getMockRepoArticlesViewModel() -> NYTImesArticleViewModel{
        NYTImesArticleViewModel(repository: MockArticleRepository())
    }
}
