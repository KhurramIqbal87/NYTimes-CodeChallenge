//
//  NYTimesArticleDetailCoordinator.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 11/02/2025.
//

import Foundation
import UIKit

final class NYTimesArticleDetailCoordinator: NYTimesArticleDetailCoordinatorType, Coordinator {
    
    let parentCoordinator: Coordinator?
    private let naivgationType: NavigationType
    private let article: NYTimesArticle
    init(
        parentCoordinator: Coordinator?,
        navigationType: NavigationType,
        article: NYTimesArticle
    ) {
        self.parentCoordinator = parentCoordinator
        self.naivgationType = navigationType
        self.article = article
    }

    func start() {
        let detailController = NYTimesArticleDetailContainer().getArticleDetailViewController(
            coordinator: self,
            article: article
        )
        naivgationType.handleNavigation(controller: detailController)
    }
    func didNavigateBack() {
        (parentCoordinator as? ParentCoordinator)?.didFinishChildCoordinator(coordintor: self)
    }
}
