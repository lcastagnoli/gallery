//
//  SectionView.swift
//
//
//  Created by Laryssa Castagnoli on 21/02/24.
//

import UIKit

public final class SectionView: UIView {

    // MARK: Properties
    private var titleLabel = UILabel()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(scrollView)
        stackView.distribution = .fillProportionally
        return stackView
    }()

    lazy var stackViewCards: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.spacing
        return stackView
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(stackViewCards)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private var items: [CardView] = []

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

        titleLabel.style(as: .title)
        addSubview(stackView)
        configureConstraints()
    }

    public func setup(with viewModel: SectionViewModel) {

        titleLabel.text = viewModel.title
        viewModel.items.forEach { item in
            let card = CardView()
            card.translatesAutoresizingMaskIntoConstraints = false
            card.setup(with: CardViewModel(image: item))
            stackViewCards.addArrangedSubview(card)
            card.widthAnchor.constraint(equalToConstant: Constants.width).isActive = true
            card.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        }
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
