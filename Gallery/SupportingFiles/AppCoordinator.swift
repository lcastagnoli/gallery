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

        openSplash()
    }

    private func openSplash() {

        let client = APIClient(session: URLSession.shared)
        let service = AuthenticationService(client: client)
        let security = Security()
        let repository = SplashRepository(service: service, security: security)
        let dependencies = SplashViewModel.Dependencies(navigation: self, repository: repository)
        let viewModel = SplashViewModel(dependencies: dependencies)
        let viewController = SplashViewController(with: viewModel)
        setRoot(viewController)
    }

    private func openHome() {

        let tabBarController = HomeViewController(with: HomeViewModel())
        let coordinator = HomeCoordinator(tabBarController: tabBarController)
        setRoot(coordinator)
    }
}

extension AppCoordinator: SplashNavigationDelegate {

    func splash(didFinish result: SplashViewModel.Result) {
        switch result {
        case .success:
          openHome()
        case let .error(error):
            break
        }
    }
}
