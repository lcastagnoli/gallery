//
//  ListViewController.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import UIKit
import Combine

final class ListViewController: UIViewController {

    // MARK: Properties
    private let viewModel: ListViewModelProtocol
    private let customView = ListView()
    var cancellables = Set<AnyCancellable>()

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

        viewModel.getPopularMovies()
        viewModel.loadingPublisher
            .sink { [weak self] value in
                self?.customView.loading(animated: value)
            }
            .store(in: &cancellables)
        viewModel.itemsPublisher
            .sink { [weak self] value in
                self?.customView.setup(with: value)
            }
            .store(in: &cancellables)
    }
}
