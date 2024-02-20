//
//  UIView+Extension.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import UIKit

extension UIView {

    public func constraintsEqualToSuperview() {

        translatesAutoresizingMaskIntoConstraints = false

        guard let superview = superview else { return }

        NSLayoutConstraint.activate([

            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }

    public func constraintsGreaterThanOrEqualToSuperview() {

        translatesAutoresizingMaskIntoConstraints = false

        guard let superview = superview else { return }

        NSLayoutConstraint.activate([

            bottomAnchor.constraint(greaterThanOrEqualTo: superview.bottomAnchor),
            topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor),
            leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor),
            trailingAnchor.constraint(greaterThanOrEqualTo: superview.trailingAnchor)
        ])
    }

    public func constraintsEqualToSuperview(top: CGFloat = .zero,
                                            bottom: CGFloat = .zero,
                                            leading: CGFloat = .zero,
                                            trailing: CGFloat = .zero) {

        translatesAutoresizingMaskIntoConstraints = false

        guard let superview = superview else { return }

        NSLayoutConstraint.activate([

            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing)
        ])
    }

    public func constraints(view: UIView, bottom: CGFloat = .zero) {

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom),
            centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    public func constraintsAlignedCenterInSuperview() {

        translatesAutoresizingMaskIntoConstraints = false

        guard let superview = superview else { return }

        NSLayoutConstraint.activate([

            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
}
