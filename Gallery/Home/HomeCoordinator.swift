//
//  HomeCoordinator.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import GalleryNavigation
import UIKit

final class HomeCoordinator: TabBarRoutable {

    // MARK: Properties
    var childCoordinators: [Coordinator] = []
    var tabBarController: UITabBarController

    private lazy var listTab: TabItem = {

        let tab = TabItemType.list
        return TabItem(title: tab.title, icon: tab.image, item: tab.coordinator)
    }()

    private lazy var favoritesTab: TabItem = {

        let tab = TabItemType.favorites
        return TabItem(title: tab.title, icon: tab.image, item: tab.coordinator)
    }()

    // MARK: Initializers
    init(tabBarController: UITabBarController) {

        self.tabBarController = tabBarController
    }
}

// MARK: - Coordinator
extension HomeCoordinator: Coordinator {

    func start() {

        setRoot([listTab, favoritesTab])
    }
}
