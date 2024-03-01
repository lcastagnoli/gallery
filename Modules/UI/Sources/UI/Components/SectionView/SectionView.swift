//
//  SectionView.swift
//
//
//  Created by Laryssa Castagnoli on 21/02/24.
//

import UIKit

public protocol SectionViewDelegate: AnyObject {

    func didSelect(card: CardView, index: Int, section: Int)
    func didSelect(section: SectionView, index: Int)
}

public final class SectionView: UIView {

    // MARK: Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.style(as: .title)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(scrollView)
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var stackViewCards: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.spacing
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(stackViewCards)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private weak var delegate: SectionViewDelegate?
    private var viewModel: SectionViewModel?

    // MARK: Constants
    private enum Constants {
        static let spacing = 16.0
        static let topAnchor = 20.0
        static let width = 100.0
        static let height = 150.0
    }

    // MARK: Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods
    private func setupViews() {

        addSubview(stackView)
        configureConstraints()
    }

    public func setup(with viewModel: SectionViewModel, delegate: SectionViewDelegate?) {

        self.viewModel = viewModel
        self.delegate = delegate
        titleLabel.text = viewModel.title

        for item in viewModel.items {
            createCard(with: item)
        }
    }

    private func createCard(with viewModel: CardViewModel?) {

        guard let viewModel else { return }
        let card = CardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.setup(with: viewModel, delegate: self)
        card.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true
        card.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        stackViewCards.addArrangedSubview(card)
    }

    private func configureConstraints() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackViewCards.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            scrollView.heightAnchor.constraint(equalToConstant: Constants.height),
            stackViewCards.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackViewCards.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackViewCards.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackViewCards.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

// MARK: - CardViewDelegate
extension SectionView: CardViewDelegate {

    public func didSelect(view: CardView, index: Int) {

        guard let section = viewModel?.index else { return }
        delegate?.didSelect(card: view, index: index, section: section)
    }
}
