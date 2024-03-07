//
//  ListView.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import UIKit
import UI

public protocol ListViewDelegate: AnyObject {

    func didSelect(card: CardView, index: Int, section: Int)
    func didSelect(section: SectionView, index: Int)
}

final class ListView: UIView {

    // MARK: Constants
    private enum Constants {
        static let spacing = 40.0
        static let heightSection = 170.0
        static let topInset = 20.0
        static let bottomInset = 40.0
    }

    // MARK: Properties
    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.color = .white
        return loader
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Constants.spacing
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(stackView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = stackView.bounds.size
        scrollView.bounces = false
        scrollView.contentInset = UIEdgeInsets(top: Constants.topInset,
                                               left: .zero,
                                               bottom: Constants.bottomInset,
                                               right: .zero)
        return scrollView
    }()

    private lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.isHidden = true
        addSubview(errorView)
        return errorView
    }()

    private weak var delegate: ListViewDelegate?

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: Methods
    public func setup(with viewModels: [SectionViewModel], delegate: ListViewDelegate?) {

        self.delegate = delegate
        viewModels.forEach { viewModel in

            createSection(with: viewModel)
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

    public func show(error viewModel: ErrorViewModel) {
        errorView.setup(with: viewModel)
        errorView.isHidden = false
        scrollView.isHidden = true
    }

    private func createSection(with viewModel: SectionViewModel) {

        let section = SectionView()
        section.setup(with: viewModel, delegate: self)
        section.translatesAutoresizingMaskIntoConstraints = true
        stackView.addArrangedSubview(section)
        section.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.heightSection).isActive = true
    }

    private func setupViews() {

        backgroundColor = .black
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
        errorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            errorView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - SectionViewDelegate
extension ListView: SectionViewDelegate {

    func didSelect(card: CardView, index: Int, section: Int) {
        delegate?.didSelect(card: card, index: index, section: section)
    }
    func didSelect(section: SectionView, index: Int) {
        delegate?.didSelect(section: section, index: index)
    }
}
