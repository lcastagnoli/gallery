//
//  SplashView.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import UIKit
import UI

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

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: Methods
    private func setupViews() {

        backgroundColor = .black
        backgroundImage.contentMode = .scaleAspectFill
        loader.color = .white
        addSubview(backgroundImage)
        addSubview(loader)
        configureConstraints()
    }

    private func configureConstraints() {

        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loader.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                           constant: Constants.bottomConstraint),
            backgroundImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
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
