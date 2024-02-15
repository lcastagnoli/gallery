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
        super.init(nibName: nil, bundle: Bundle(for: HomeViewController.self))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Methods
    private func configureTabs() {
        
    }
}
