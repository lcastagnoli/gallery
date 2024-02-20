//
//  NavigationRoutable.swift
//  
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import UIKit

public protocol NavigationRoutable: Routable {

    var navigation: UINavigationController { get set }
    var completions: [UIViewController: (() -> Void)] { get set }
}

extension NavigationRoutable {

    public func push(_ controller: UIViewController, animated: Bool = true) {

        navigation.pushViewController(controller, animated: animated)
    }

    public func pop(animated: Bool = true) {

        navigation.popViewController(animated: animated)
    }
}

extension NavigationRoutable {

    public var root: UIViewController { navigation }
    public var visibleViewController: UIViewController? { navigation.visibleViewController }

    public func setRoot(_ controller: UIViewController, animated: Bool = true) {

        push(controller, animated: animated)
    }

    public func present(_ controller: UIViewController) {

        navigation.present(controller, animated: true)
    }

    public func dismiss(_ animated: Bool = true) {

        navigation.dismiss(animated: animated)
    }
}

// MARK: - UINavigationControllerDelegate
extension NavigationRoutable where Self: UINavigationControllerDelegate {

    public func executeCompletions(for viewController: UIViewController) {

        guard
            let fromViewController = navigation.transitionCoordinator?.viewController(forKey: .from),
            !navigation.viewControllers.contains(fromViewController) else {
            return
        }

        completions[fromViewController]?()
    }
}

