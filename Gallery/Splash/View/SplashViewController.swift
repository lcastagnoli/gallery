//
//  SplashViewController.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import UIKit
import Combine

final class SplashViewController: UIViewController {

    // MARK: Properties
    private let viewModel: SplashViewModelProtocol
    private let customView = SplashView()
    var cancellables = Set<AnyCancellable>()

    // MARK: Initializers
    init(viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        customView.configureView(with: Images.splash)
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.startGuestSession()
        viewModel.loadingPublisher
            .sink { [weak self] value in
                self?.customView.loading(animated: value)
            }
            .store(in: &cancellables)
    }
}
