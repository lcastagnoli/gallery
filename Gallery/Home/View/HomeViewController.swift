//
//  HomeViewController.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import UIKit

final class HomeViewController: UITabBarController {

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
        configureTabs()
    }

    // MARK: Methods
    private func configureTabs() {
        tabBar.backgroundColor = .black.withAlphaComponent(0.4)
        tabBar.tintColor = .white

        let tabs: [TabItemType] = [.list, .favorites]
        viewControllers = tabs.map { $0.viewController }
        for (index, type) in tabs.enumerated() {
            viewControllers?[index].tabBarItem = .init(type: type)
        }
    }
}
