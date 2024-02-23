//
//  CardView.swift
//
//
//  Created by Laryssa Castagnoli on 21/02/24.
//

import UIKit
import SDWebImage

public final class CardView: UIView {

    // MARK: Constants
    private enum Constants {
        static let width = 100.0
        static let height = 150.0
    }

    // MARK: Properties
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods
    private func setupViews() {
        addSubview(imageView)
        configureConstraints()
    }

    public func setup(with viewModel: CardViewModel) {
        imageView.sd_setImage(with: URL(string: Environment.baseImageUrl.absoluteString + viewModel.image),
                              placeholderImage: UIImage(named: Images.placeholder))
    }

    private func configureConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.width),
            imageView.heightAnchor.constraint(equalToConstant: Constants.height)
        ])
    }
}
