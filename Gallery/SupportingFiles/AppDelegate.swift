//
//  AppDelegate.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 12/02/24.
//

import UIKit
import GalleryNetwork

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeViewController(with: HomeViewModel(repository: HomeRepository(service: HomeService(client: APIClient(session: URLSession.shared)))))
        window?.makeKeyAndVisible()

        return true
    }
}
