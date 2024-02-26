//
//  FavoritesCoordinator.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import Navigation
import Persistence
import UIKit

final class FavoritesCoordinator: NavigationRoutable {

    var navigation: UINavigationController
    var childCoordinators: [Coordinator] = []
    var completions: [UIViewController: (() -> Void)] = [:]

    private lazy var favoritesViewController: FavoritesViewController = {
        let dependencies = FavoritesViewModel.Dependencies(persistence: PersistenceManager())
        return FavoritesViewController(with: FavoritesViewModel(dependencies: dependencies))
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
