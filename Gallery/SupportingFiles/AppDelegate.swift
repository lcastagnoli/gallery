//
//  AppDelegate.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 12/02/24.
//

import UIKit
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        let coordinator = AppCoordinator(window: window)
        coordinator.start()
        self.coordinator = coordinator
        self.window = window
        return true
    }
}
