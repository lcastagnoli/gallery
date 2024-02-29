//
//  DetailsViewController.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 26/02/24.
//

import UIKit
import Combine
import UI

final class DetailsViewController: UIViewController {

    // MARK: Constants
    private enum Constants {
        static let spacingItems = 20.0
        static let height = 150.0
    }

    // MARK: IBOutlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var headerView: HeaderView!
    @IBOutlet private weak var segmentView: SegmentView!
    @IBOutlet private weak var recommendationsCollectionView: UICollectionView!
    @IBOutlet private weak var dataSheetView: DataSheetView!
    @IBOutlet private weak var recommendationsHeight: NSLayoutConstraint!
    @IBOutlet private weak var errorView: ErrorView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!

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
        setupViews()
        bindViews()
    }

    // MARK: Methods
    private func bindViews() {

        viewModel.loadingPublisher
            .sink { [weak self] value in
                self?.loading(animated: value)
            }
            .store(in: &cancellables)
        viewModel.errorPublisher
            .sink { [weak self] value in
                guard let value else { return }
                self?.show(error: value)
            }
            .store(in: &cancellables)
        viewModel.headerPublisher
            .sink { [weak self] value in
                guard let value else { return }
                self?.headerView.setup(with: value, delegate: self)
            }
            .store(in: &cancellables)
    }

    private func setupViews() {

        loader.color = .white
        errorView.backgroundColor = .black
        segmentView.setup(with: viewModel.segmentViewModels, delegate: self)
        recommendationsCollectionView.dataSource = self
        recommendationsCollectionView.delegate = self
        recommendationsCollectionView.backgroundColor = .blackGrey
        recommendationsCollectionView.register(class: CollectionCell<CardView>.self)
    }

    public func loading(animated: Bool) {

        loader.isHidden = !animated
        scrollView.isHidden = animated
        stackView.isHidden = animated
        errorView.isHidden = true
        switch animated {
        case true:
            loader.startAnimating()
        case false:
            loader.stopAnimating()
            configureViews()
        }
    }

    public func show(error viewModel: ErrorViewModel) {
        errorView.setup(with: viewModel)
        errorView.isHidden = false
        scrollView.isHidden = true
    }

    private func configureViews() {

        guard let dataSheetViewModel = viewModel.dataSheetViewModel else { return }
        dataSheetView.setup(with: dataSheetViewModel)
        segmentView.didSelectTab(at: .zero)
        defineSecommendationsHeight()
    }

    private func defineSecommendationsHeight() {

        let count = Double(viewModel.cardViewModels.count/3)
        let collectionHeight = count * Constants.height + count * Constants.spacingItems
        recommendationsHeight.constant = collectionHeight
        recommendationsCollectionView.reloadData()
    }
}

// MARK: - HeaderViewDelegate
extension DetailsViewController: HeaderViewDelegate {

    func didTapWatch() {

        viewModel.watch()
    }

    func didTapFavorite() {

        viewModel.tapFavorite()
    }
}

// MARK: SegmentViewDelegate
extension DetailsViewController: SegmentViewDelegate {

    func didSelect(segment: UI.SegmentView, index: Int) {

        dataSheetView.isHidden = index == 1
        recommendationsCollectionView.isHidden = index == .zero
    }
}

extension DetailsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cardViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeue(CollectionCell<CardView>.self, at: indexPath)
        cell.view.setup(with: viewModel.cardViewModels[safe: indexPath.item], delegate: nil)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailsViewController: UICollectionViewDelegateFlowLayout {

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
        let width = (view.frame.width - Constants.spacingItems*3)/3
        return CGSize(width: width, height: Constants.height)
    }
}

// MARK: - UICollectionViewDelegate
extension DetailsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelect(recommended: indexPath.item)
    }
}
