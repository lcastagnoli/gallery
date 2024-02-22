//
//  ListCoordinator.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import Navigation
import Network
import UIKit

final class ListCoordinator: NavigationRoutable {

    var navigation: UINavigationController
    var completions: [UIViewController: (() -> Void)] = [:]
    var childCoordinators: [Coordinator] = []
    private lazy var listViewController: ListViewController = {

        let client = APIClient(session: URLSession.shared)
        let service = MovieService(client: client)
        let repository = ListRepository(service: service)
        let dependencies = ListViewModel.Dependencies(repository: repository)
        let viewModel = ListViewModel(dependencies: dependencies)
        return ListViewController(with: viewModel)
    }()

    // MARK: Initializers
    init(navigation: UINavigationController) {

        self.navigation = navigation
    }
}

extension ListCoordinator {

    func start() {
        setRoot(listViewController)
    }
}
