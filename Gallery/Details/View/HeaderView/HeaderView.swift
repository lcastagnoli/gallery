//
//  HeaderView.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 26/02/24.
//

import UIKit
import UI
import SDWebImage

protocol HeaderViewDelegate: AnyObject {

    func didTapWatch()
    func didTapFavorite()
}

final class HeaderView: UIView {

    // MARK: Constants
    private enum Constants {
        static let spacing = 8.0
        static let paddingLabelEdges = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        static let overlayAlpha = 0.7
    }

    // MARK: IBOutlets
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genresStackView: UIStackView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var watchButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!

    // MARK: Properties
    private weak var delegate: HeaderViewDelegate?

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        loadNib()
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        loadNib()
        setupView()
    }

    // MARK: Methods
    private func setupView() {

        titleLabel.style(as: .title)
        descriptionLabel.style(as: .description)
        descriptionLabel.numberOfLines = .zero
        titleLabel.numberOfLines = .zero
        posterImageView.contentMode = .scaleAspectFill
        genresStackView.axis = .horizontal
        genresStackView.spacing = Constants.spacing
        genresStackView.distribution = .fillProportionally
        watchButton.style(as: .play)
        favoriteButton.style(as: .favorite)
        watchButton.setImage(UIImage(named: Images.play), for: .normal)
        watchButton.setTitle(TranslationKeys.buttonPlay.localized, for: .normal)
        watchButton.setTitle(TranslationKeys.unavailable.localized, for: .disabled)
        let darkOverlay = UIView(frame: CGRect(origin: .zero, size: posterImageView.frame.size))
        darkOverlay.backgroundColor = UIColor.black.withAlphaComponent(Constants.overlayAlpha)
        posterImageView.addSubview(darkOverlay)
    }

    private func changeFavorite(favorited: Bool) {

        let title = favorited ?
        TranslationKeys.buttonFavoriteChecked.localized :
        TranslationKeys.buttonFavoriteUnchecked.localized
        let image = favorited ? Images.star : Images.check
        favoriteButton.setTitle(title, for: .normal)
        favoriteButton.setImage(UIImage(named: image), for: .normal)
    }

    func setup(with viewModel: HeaderViewModel, delegate: HeaderViewDelegate?) {

        self.delegate = delegate
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        watchButton.isEnabled = viewModel.hasVideo
        let url = URL(string: Environment.baseImageUrl.absoluteString + viewModel.image.unwrapped)
        posterImageView.sd_setImage(with: url, placeholderImage: UIImage(named: Images.placeholder))
        changeFavorite(favorited: viewModel.favorited)
        configure(genres: viewModel.genres)
    }

    private func configure(genres: [String]?) {

        genresStackView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        genres?.forEach { genre in
            let genreLabel = PaddingLabel(style: .genre)
            genreLabel.edgeInset = Constants.paddingLabelEdges
            genreLabel.text = genre
            genresStackView.addArrangedSubview(genreLabel)
        }
    }

    // MARK: IBActions
    @IBAction private func actionFavorite(_ sender: UIButton) {
        delegate?.didTapFavorite()
    }

    @IBAction private func actionWatch(_ sender: UIButton) {
        delegate?.didTapWatch()
    }
}

// MARK: NibLoadable
extension HeaderView: NibLoadable {}
