//
//  SplashView.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import UIKit

final class SplashView: UIView {

    // MARK: Constants
    private enum Constants {
        static let bottomConstraint = -20.0
    }

    // MARK: Properties
    private var backgroundImage = UIImageView()
    private var loader = UIActivityIndicatorView(style: .medium)

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
        backgroundImage.contentMode = .scaleAspectFill
        loader.color = .white
        addSubview(backgroundImage)
        addSubview(loader)
        configureConstraints()
    }

    private func configureConstraints() {
        backgroundImage.constraintsEqualToSuperview()
        loader.translatesAutoresizingMaskIntoConstraints = false
        let constrants = [NSLayoutConstraint(item: loader,
                                                  attribute: .centerXWithinMargins,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .centerXWithinMargins,
                                                  multiplier: 1,
                                                  constant: .zero),
                               NSLayoutConstraint(item: loader,
                                                  attribute: .bottomMargin,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .bottomMargin,
                                                  multiplier: 1,
                                                  constant: Constants.bottomConstraint)]
        NSLayoutConstraint.activate(constrants)
    }

    func configureView(with imageNamed: String) {

        backgroundImage.image = UIImage(named: imageNamed)
    }

    public func loading(animated: Bool) {
        switch animated {
        case true:
            loader.startAnimating()
        case false:
            loader.stopAnimating()
        }
    }
}
