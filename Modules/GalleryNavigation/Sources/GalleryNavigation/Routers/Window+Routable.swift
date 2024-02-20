//
//  WindowRoutable.swift
//  
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import UIKit

public protocol WindowRoutable: Routable {

    var window: UIWindow { get set }
}

extension WindowRoutable {

    public var root: UIViewController {
        guard let root = window.rootViewController else { fatalError("window.rootViewController not found") }
        return root
    }

    public func present(_ controller: UIViewController) {

        root.present(controller, animated: true)
    }

    public func dismiss(_ animated: Bool = true) {

        root.dismiss(animated: animated)
    }

    public func setRoot(_ controller: UIViewController, animated: Bool = true) {

        window.rootViewController = controller
        window.makeKeyAndVisible()

        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }

    public func setRoot(_ coordinator: Routable) {

        add(coordinator)
        coordinator.start()
        setRoot(coordinator.root)
    }

    public func present(_ coordinator: Routable, backButton: UIBarButtonItem? = nil, animated: Bool = true) {

        add(coordinator)
        coordinator.start()
        if let navigation = coordinator.root as? UINavigationController {
            navigation.viewControllers.first?.navigationItem.leftBarButtonItem = backButton
        }
        coordinator.root.modalPresentationStyle = .fullScreen
        coordinator.root.modalTransitionStyle = .crossDissolve

        root.present(coordinator.root, animated: animated)
    }

    public func dismiss(_ coordinator: Routable, animated: Bool = true) {

        remove(coordinator)
        coordinator.root.dismiss(animated: animated)
    }
}

