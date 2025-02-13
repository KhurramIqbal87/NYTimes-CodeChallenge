//
//  NYTimesArticleDetailContainer.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 11/02/2025.
//

import Foundation

struct NYTimesArticleDetailContainer {
    func getArticleDetailViewController(
        coordinator: NYTimesArticleDetailCoordinatorType,
        article: NYTimesArticle
    ) -> NYTimesDetailViewController<NYTimeArticlesDetailViewModel> {
         NYTimesDetailViewController(
            viewModel: getArticleDetailViewModel(article: article),
            coordinator: coordinator
        )
    }
    
    func getArticleDetailViewModel(article: NYTimesArticle) -> NYTimeArticlesDetailViewModel {
        NYTimeArticlesDetailViewModel(
            article: article,
            repository: getImageRepository()
        )
    }
    
    func getImageRepository() -> ImageRepositoryType {
        ImageRepository(apiClient: ApiClient.sharedInstance)
    }
    
    func createMockRepoViewModel(article: NYTimesArticle) -> NYTimeArticlesDetailViewModel {
        let repo = MockImageRepository()
        return NYTimeArticlesDetailViewModel (
            article: article,
            repository: repo
        )
    }
    
}
