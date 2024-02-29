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

protocol DetailsCoordinatorDelegate: AnyObject {

    func didFinish(coordinator: DetailsCoordinator, result: DetailsCoordinator.Result)
}

final class DetailsCoordinator: NavigationRoutable {

    enum Result {

        case recommended(Int)
    }

    var navigation: UINavigationController
    var completions: [UIViewController: (() -> Void)] = [:]
    var childCoordinators: [Coordinator] = []
    var movieId: Int
    weak var delegate: DetailsCoordinatorDelegate?

    private lazy var detailsViewController: DetailsViewController = {

        let client = APIClient(session: URLSession.shared)
        let service = MovieService(client: client)
        let persistence = PersistenceManager()
        let repository = DetailsRepository(service: service, persistence: persistence, movieId: movieId)
        let dependencies = DetailsViewModel.Dependencies(navigation: self, repository: repository)
        let viewModel = DetailsViewModel(dependencies: dependencies)
        return DetailsViewController(with: viewModel)
    }()

    // MARK: Initializers
    init(navigation: UINavigationController, movieId: Int, delegate: DetailsCoordinatorDelegate?) {

        self.navigation = navigation
        self.movieId = movieId
        self.delegate = delegate
    }
}

extension DetailsCoordinator {

    func start() {
        setRoot(detailsViewController)
    }
}

// MARK: - DetailsNavigationDelegate
extension DetailsCoordinator: DetailsNavigationDelegate {

    func details(didFinish result: DetailsViewModel.Result) {
        switch result {
        case let .recommended(id):
            delegate?.didFinish(coordinator: self, result: .recommended(id))
        default: break
        }
    }
}
