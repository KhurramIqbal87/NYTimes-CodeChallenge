//
//  AppCoordinator.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 11/02/2025.
//

import Foundation
import UIKit

final class AppCoordinator: ParentCoordinator{
    var childCoordinators: [Coordinator]?
    
    var parentCoordinator: Coordinator?
    private var window: UIWindow
    init(window: UIWindow){
        self.window = window
    }
    
    func didFinishChildCoordinator(coordintor: Coordinator) {
        self.childCoordinators?.removeAll(where: { coordinator in
            return coordinator === coordintor
        })
    }
   
    func start() {
        let nyTimesArticleCoordinator = NYTimesArticleCoordinator.init(
            parentCoordinator: self,
            navigationType: .windowRootViewController(window: window)
        )
        nyTimesArticleCoordinator.start()
        self.childCoordinators?.append(nyTimesArticleCoordinator)
    }
}
