//
//  NavigationType.swift
//  NYTimes-Challenge
//
//  Created by MAC918046 on 11/02/2025.
//

import Foundation
import UIKit
typealias VoidClosure = (() -> Void)

enum NavigationType {
    case push(navigationController: UINavigationController?)
    case present(navigationController: UINavigationController?, completion: VoidClosure? )
    case windowRootViewController(window: UIWindow)
    case popViewController(navigationController: UINavigationController)
    case popToRootController(navigationController: UINavigationController)
    case dismissController(completion: VoidClosure?)
    
    func handleNavigation(controller: UIViewController) {
        switch self {
        case .push(let navController):
            navController?.pushViewController(controller, animated: true)
        case .present(let navController, let completion):
            navController?.present(controller, animated: true) {
                completion?()
            }
        case .windowRootViewController(let window):
            window.rootViewController = controller
            window.makeKeyAndVisible()
        case .popViewController(let navController):
            navController.pushViewController(controller, animated: true)
        case .popToRootController(let navController):
            navController.popViewController(animated: true)
        case .dismissController(completion: let completion):
            controller.dismiss(animated: true) {
                completion?()
            }
        }
    }
}
