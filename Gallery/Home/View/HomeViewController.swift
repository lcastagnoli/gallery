//
//  HomeViewController.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import UIKit

final class HomeViewController: UITabBarController {

    // MARK: Constants
    private enum Constants {
        static let alpha = 0.4
    }

    // MARK: Properties
    private let viewModel: HomeViewModelProtocol

    // MARK: Initializer
    init(with viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .black
        tabBar.tintColor = .white
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .black
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance

    }
}
