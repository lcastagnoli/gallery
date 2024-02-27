//
//  DetailsViewController.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 26/02/24.
//

import UIKit
import Combine

final class DetailsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var headerView: HeaderView!

    // MARK: Properties
    private let viewModel: DetailsViewModelProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initializers
    init(with viewModel: DetailsViewModelProtocol) {

        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle(for: DetailsViewController.self))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getMovie()
        viewModel.headerPublisher
            .sink { [weak self] value in
                guard let headerViewModel = value else { return }
                self?.configureHeader(with: headerViewModel)
            }
            .store(in: &cancellables)
    }

    // MARK: Methods
    private func configureHeader(with viewModel: HeaderViewModel) {
        headerView.setup(with: viewModel, delegate: self)
    }
}

// MARK: - HeaderViewDelegate
extension DetailsViewController: HeaderViewDelegate {

    func didTapWatch() { }

    func didTapFavorite() {

        viewModel.tapFavorite()
    }
}
