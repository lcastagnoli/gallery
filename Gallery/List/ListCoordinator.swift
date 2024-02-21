//
//  ListCoordinator.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import Navigation
import UIKit

final class ListCoordinator: NavigationRoutable {

    var navigation: UINavigationController
    var completions: [UIViewController: (() -> Void)] = [:]
    var childCoordinators: [Coordinator] = []
    private lazy var listViewController: ListViewController = {
        return ListViewController()
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
