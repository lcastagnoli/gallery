//
//  FavoritesView.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 23/02/24.
//

import UIKit
import UI

final class FavoritesView: UIView {

    private enum Constants {
        static let spacingItems = 20.0
        static let height = 150.0
    }

    // MARK: Properties
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(class: CollectionCell<CardView>.self)
        return collectionView
    }()

    private var viewModels: [CardViewModel] = []

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: Methods
    public func setup(with viewModels: [CardViewModel]) {

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

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
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
