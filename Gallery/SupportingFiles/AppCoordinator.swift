//
//  AppCoordinator.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import Foundation
import Navigation
import UIKit
import Network
import Persistence

final class AppCoordinator: WindowRoutable {

    // MARK: Properties
    var window: UIWindow
    var childCoordinators: [Coordinator] = []

    // MARK: Initializers
    init(window: UIWindow) {

        self.window = window
    }
}

// MARK: - Coordinator
extension AppCoordinator: Coordinator {

    func start() {

        openHome()
    }

    private func openHome() {

        let tabBarController = HomeViewController(with: HomeViewModel())
        let coordinator = HomeCoordinator(tabBarController: tabBarController)
        setRoot(coordinator)
    }
}
