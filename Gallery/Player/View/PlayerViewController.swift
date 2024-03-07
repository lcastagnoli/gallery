//
//  PlayerViewController.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 29/02/24.
//

import UIKit
import WebKit

final class PlayerViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var webView: WKWebView!

    // MARK: Properties
    private let viewModel: PlayerViewModelProtocol

    // MARK: Initializers
    init(with viewModel: PlayerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle(for: PlayerViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        webView.backgroundColor = .black
        webView.load(URLRequest(url: viewModel.videoUrl))
    }
}
