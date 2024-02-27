//
//  DetailsCoordinator.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 26/02/24.
//

import Foundation
import Navigation
import UIKit
import Network
import Persistence

final class DetailsCoordinator: NavigationRoutable {

    var navigation: UINavigationController
    var completions: [UIViewController: (() -> Void)] = [:]
    var childCoordinators: [Coordinator] = []
    var movieId: Int

    private lazy var detailsViewController: DetailsViewController = {

        let client = APIClient(session: URLSession.shared)
        let service = MovieService(client: client)
        let persistence = PersistenceManager()
        let repository = DetailsRepository(service: service, persistence: persistence, movieId: movieId)
        let dependencies = DetailsViewModel.Dependencies(repository: repository)
        let viewModel = DetailsViewModel(dependencies: dependencies)
        return DetailsViewController(with: viewModel)
    }()

    // MARK: Initializers
    init(navigation: UINavigationController, movieId: Int) {

        self.navigation = navigation
        self.movieId = movieId
    }
}

extension DetailsCoordinator {

    func start() {
        setRoot(detailsViewController)
    }
}
