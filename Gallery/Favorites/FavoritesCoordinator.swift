//
//  FavoritesCoordinator.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import Navigation
import UIKit

final class FavoritesCoordinator: NavigationRoutable {

    var navigation: UINavigationController
    var childCoordinators: [Coordinator] = []
    var completions: [UIViewController: (() -> Void)] = [:]

    private lazy var favoritesViewController: FavoritesViewController = {
        return FavoritesViewController()
    }()

    // MARK: Initializers
    init(navigation: UINavigationController) {

        self.navigation = navigation
    }
}

extension FavoritesCoordinator {

    func start() {
        setRoot(favoritesViewController)
    }
}
