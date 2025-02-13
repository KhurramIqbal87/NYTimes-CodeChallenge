//
//  AppCoordinator.swift
//  NYTimes-Challenge
//
//  Created by Khurram iqbal on 11/02/2025.
//

import Foundation

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get }
    func start()
}
