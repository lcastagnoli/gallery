//
//  ErrorView.swift
//
//
//  Created by Laryssa Castagnoli on 29/02/24.
//

import UIKit

public final class ErrorView: UIView {

    // MARK: IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!

    // MARK: Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        setupViews()
    }

    // MARK: Methods
    private func setupViews() {

        titleLabel.style(as: .title)
        textLabel.style(as: .content)
        titleLabel.textAlignment = .center
        textLabel.textAlignment = .center
        titleLabel.numberOfLines = .zero
        textLabel.numberOfLines = .zero
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
    }

    public func setup(with viewModel: ErrorViewModel) {

        titleLabel.text = viewModel.title
        textLabel.text = viewModel.text
    }
}

// MARK: NibLoadable
extension ErrorView: NibLoadable {}
