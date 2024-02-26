//
//  HeaderView.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 26/02/24.
//

import UIKit
import UI
import SDWebImage

final class HeaderView: UIView {

    // MARK: Constants
    private enum Constants {
        static let spacing = 8.0
    }

    // MARK: IBOutlets
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genresStackView: UIStackView!

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }

    // MARK: Methods
    private func setupView() {

        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: .main)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.backgroundColor = .clear
        addSubview(view)
        
        titleLabel.style(as: .title)
        posterImageView.contentMode = .scaleAspectFill
        genresStackView.axis = .horizontal
        genresStackView.spacing = Constants.spacing
    }

    func setup(with viewModel: HeaderViewModel) {

        titleLabel.text = viewModel.title
        posterImageView.sd_setImage(with: URL(string: Environment.baseImageUrl.absoluteString + viewModel.image),
                              placeholderImage: UIImage(named: Images.placeholder))

        viewModel.genres?.forEach { genre in
            let genreLabel = UILabel()
            genreLabel.style(as: .genre)
            genreLabel.text = genre
            genresStackView.addArrangedSubview(genreLabel)
        }
    }
}
