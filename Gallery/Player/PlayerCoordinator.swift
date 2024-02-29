//
//  PlayerCoordinator.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 29/02/24.
//
import Navigation
import Foundation
import UIKit

final class PlayerCoordinator: NavigationRoutable {

    var navigation: UINavigationController
    var completions: [UIViewController: (() -> Void)] = [:]
    var childCoordinators: [Coordinator] = []
    private var url: URL

    private lazy var playerViewController: PlayerViewController = {

        let dependencies = PlayerViewModel.Dependencies(url: url)
        let viewModel = PlayerViewModel(dependencies: dependencies)
        return PlayerViewController(with: viewModel)
    }()

    // MARK: Initializers
    init(navigation: UINavigationController, url: URL) {

        self.navigation = navigation
        self.url = url
    }
}

extension PlayerCoordinator {

    func start() {
        setRoot(playerViewController)
    }
}
