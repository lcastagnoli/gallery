//
//  FavoritesView.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 23/02/24.
//

import UIKit
import UI

protocol FavoritesViewDelegate: AnyObject {
    func didSelect(view: FavoritesView, index: Int)
}

final class FavoritesView: UIView {

    // MARK: Constants
    private enum Constants {
        static let spacingItems = 20.0
        static let height = 150.0
    }

    // MARK: Properties
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(class: CollectionCell<CardView>.self)
        return collectionView
    }()

    private var viewModels: [CardViewModel] = []
    private weak var delegate: FavoritesViewDelegate?

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: Methods
    public func setup(with viewModels: [CardViewModel], delegate: FavoritesViewDelegate?) {

        self.delegate = delegate
        self.viewModels = viewModels
        collectionView.reloadData()
    }

    private func setupViews() {

        backgroundColor = .black
        collectionView.backgroundColor = .black
        addSubview(collectionView)
        configureConstraints()
    }

    private func configureConstraints() {

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeue(CollectionCell<CardView>.self, at: indexPath)
        cell.view.setup(with: viewModels[safe: indexPath.item], delegate: nil)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacingItems
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacingItems
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width - Constants.spacingItems*3)/3
        return CGSize(width: width, height: Constants.height)
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(view: self, index: indexPath.item)
    }
}
