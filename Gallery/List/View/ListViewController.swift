//
//  ListViewController.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import UIKit
import Combine
import UI

final class ListViewController: UIViewController {

    // MARK: Properties
    private let viewModel: ListViewModelProtocol
    private let customView = ListView()
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initializers
    init(with viewModel: ListViewModelProtocol) {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = TranslationKeys.navTitleMovies.localized
        viewModel.getMovies()
        viewModel.loadingPublisher
            .sink { [weak self] value in
                self?.customView.loading(animated: value)
            }
            .store(in: &cancellables)
        viewModel.itemsPublisher
            .sink { [weak self] value in
                self?.customView.setup(with: value, delegate: self)
            }
            .store(in: &cancellables)
    }
}

// MARK: - ListViewDelegate
extension ListViewController: ListViewDelegate {

    func didSelect(card: CardView, index: Int, section: Int) {

//        viewModel.addFavorite(section: section, index: index)
        viewModel.details(section: section, index: index)
    }

    func didSelect(section: SectionView, index: Int) { }
}
