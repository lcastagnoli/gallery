//
//  TabBarRoutable.swift
//
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import UIKit

public protocol TabBarRoutable: Routable {

    var tabBarController: UITabBarController { get set }
}

extension TabBarRoutable {

    public var root: UIViewController { tabBarController }

    public func setRoot(_ controller: UIViewController, animated: Bool = true) {

        guard
            let index = tabBarController.viewControllers?.firstIndex(where: { $0 == controller })
        else { fatalError("controller is not in viewControllers array") }

        tabBarController.selectedIndex = index
    }

    public func present(_ controller: UIViewController) {

        tabBarController.present(controller, animated: true)
    }

    public func dismiss(_ animated: Bool = true) {

        tabBarController.dismiss(animated: animated)
    }
}

extension TabBarRoutable {

    public func setRoot(_ tabs: [UIViewController], animated: Bool = true) {

        tabBarController.setViewControllers(tabs, animated: animated)
    }

    private func setRoot(_ coordinators: [Routable], animated: Bool = true) {

        childCoordinators.removeAll()

        for coordinator in coordinators {

            add(coordinator)
            coordinator.start()
        }

        setRoot(coordinators.map { $0.root }, animated: animated)
    }

    public func setRoot(_ tabs: [TabItem], animated: Bool = true) {

        childCoordinators.removeAll()

        for (index, tab) in tabs.enumerated() {

            tab.item.root.tabBarItem = UITabBarItem(title: tab.title,
                                                    image: UIImage(named: tab.icon),
                                                    tag: index)
            tab.item.root.tabBarItem.tag = index
            guard let coordinator = tab.item as? Routable else { continue }
            add(coordinator)
            coordinator.start()
        }

        let viewControllers = tabs.map { $0.item.root }
        setRoot(viewControllers, animated: animated)
    }

    public func setTab(index: Int) {

        tabBarController.selectedIndex = index
    }
}

