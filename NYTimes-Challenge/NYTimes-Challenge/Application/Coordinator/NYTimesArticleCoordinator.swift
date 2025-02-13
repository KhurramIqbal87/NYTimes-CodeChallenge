//
//  NYTimesArticleCoordinator.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 11/02/2025.
//

import Foundation
import UIKit

final class NYTimesArticleCoordinator: NYTimesArticleCoordinatorType, ParentCoordinator{
    var childCoordinators: [Coordinator]?
    
    let parentCoordinator: Coordinator?
    private let naivgationType: NavigationType
    private var viewModel: NYTImesArticleViewModelType?
    private var navigationController: UINavigationController?
    init(
        parentCoordinator: Coordinator?,
        navigationType: NavigationType
    ) {
        self.parentCoordinator = parentCoordinator
        self.naivgationType = navigationType
    }
    
    func didFinishChildCoordinator(coordintor: Coordinator) {
        self.childCoordinators?.removeAll(where: { $0 === coordintor } )
    }

    func start() {
        let turple = NYTimesArticleContainer().getArticlesViewController(coordinator: self)
        navigationController = UINavigationController(rootViewController: turple.0)
        naivgationType.handleNavigation(controller: navigationController ?? UINavigationController(rootViewController: turple.0))
        viewModel = turple.1
    }
    
    func navigateToDetailController(indexPath: IndexPath) {
        guard let article = viewModel?.getModelForDetailController(indexPath: indexPath) else { return }
        let detailCoordinator = NYTimesArticleDetailCoordinator(
            parentCoordinator: self,
            navigationType:.push(navigationController: navigationController),
            article: article
        )
        childCoordinators?.append(detailCoordinator)
        detailCoordinator.start()
    }
}
