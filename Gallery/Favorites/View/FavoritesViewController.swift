//
//  FavoritesViewController.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 17/02/24.
//

import UIKit
import Combine

final class FavoritesViewController: UIViewController {

    // MARK: Properties
    private let viewModel: FavoritesViewModelProtocol
    private let customView = FavoritesView()
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initializers
    init(with viewModel: FavoritesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = customView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = TranslationKeys.navTitleFavorites.localized
        getFavorites()
    }

    func getFavorites() {
        viewModel.getFavoriteMovies()

        viewModel.itemsPublisher
            .sink { [weak self] value in
                self?.customView.setup(with: value, delegate: self)
            }
            .store(in: &cancellables)
    }
}

// MARK: FavoritesViewDelegate
extension FavoritesViewController: FavoritesViewDelegate {

    func didSelect(view: FavoritesView, index: Int) {
        viewModel.didSelect(index: index)
    }
}
