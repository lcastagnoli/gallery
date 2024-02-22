//
//  ListView.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import UIKit
import UI

final class ListView: UIView {

    // MARK: Constants
    private enum Constants {
        static let spacing = 20.0
    }

    // MARK: Properties
    private var loader = UIActivityIndicatorView(style: .medium)
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.spacing
        return stackView
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(stackView)
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: Methods
    public func setup(with viewModels: [SectionViewModel]) {

        viewModels.forEach { viewModel in

            let section = SectionView()
            section.translatesAutoresizingMaskIntoConstraints = true
            section.setup(with: viewModel)
            stackView.addArrangedSubview(section)
            section.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
    }

    public func loading(animated: Bool) {

        loader.isHidden = !animated
        scrollView.isHidden = animated
        stackView.isHidden = animated
        switch animated {
        case true:
            loader.startAnimating()
        case false:
            loader.stopAnimating()
        }
    }

    private func setupViews() {

        backgroundColor = .black
        loader.color = .white
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(loader)
        configureConstraints()
        addSubview(scrollView)
    }

    private func configureConstraints() {

        loader.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),

            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
