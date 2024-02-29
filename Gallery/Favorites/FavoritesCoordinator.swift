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
        let persistence = PersistenceManager()
        let dependencies = FavoritesViewModel.Dependencies(navigation: self, persistence: persistence)
        return FavoritesViewController(with: FavoritesViewModel(dependencies: dependencies))
    }()

    // MARK: Initializers
    init(navigation: UINavigationController) {

        self.navigation = navigation
    }
}

// MARK: - Coordinator
extension FavoritesCoordinator {

    func start() {
        setRoot(favoritesViewController)
    }

    private func openDetails(_ id: Int) {
        let navigation = UINavigationController(barStyle: .transparent)
        let coordinator = DetailsCoordinator(navigation: navigation, movieId: id, delegate: self)
        let closeButton: UIBarButtonItem = .custom(icon: Images.back) { [weak self, weak coordinator] in
            guard let self = self, let coordinator = coordinator else { return }
            self.dismiss(coordinator)
            favoritesViewController.getFavorites()
        }
        present(coordinator, transition: .coverVertical, backButton: closeButton)
    }
}

// MARK: - FavoritesNavigationDelegate
extension FavoritesCoordinator: FavoritesNavigationDelegate {

    func favorites(didFinish result: FavoritesViewModel.Result) {
        switch result {
        case let .details(id):
            openDetails(id)
        }
    }
}

// MARK: - DetailsCoordinatorDelegate
extension FavoritesCoordinator: DetailsCoordinatorDelegate {

    func didFinish(coordinator: DetailsCoordinator, result: DetailsCoordinator.Result) {
        dismiss(coordinator, animated: true)
        switch result {
        case let .recommended(id):
            openDetails(id)
        }
    }
}
