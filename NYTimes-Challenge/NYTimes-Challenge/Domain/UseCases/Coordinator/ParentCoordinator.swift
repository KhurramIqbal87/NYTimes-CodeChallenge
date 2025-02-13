//
//  AppCoordinator.swift
//  NYTimes-Challenge
//
//  Created by Khurram Iqbal on 11/02/2025.
//

import Foundation

// To keep the refernce of parent and child coordinator we use ParentCoordinator so we can also update parent at times coordinator is supposed to deinit and can take possible measures
protocol ParentCoordinator: Coordinator {
    var childCoordinators: [Coordinator]? { get }
    func didFinishChildCoordinator(coordintor: Coordinator)
}
