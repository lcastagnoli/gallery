//
//  DynamicHeightCollectionCell.swift
//
//
//  Created by Laryssa Castagnoli on 23/02/24.
//

import Foundation
import UIKit

public protocol DynamicHeightCollectionCell {

    static var estimatedHeight: CGFloat { get }
}

extension DynamicHeightCollectionCell where Self: UICollectionViewCell {

    private var widthConstraint: NSLayoutConstraint {

        let const = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        const.isActive = true
        return const
    }

    public func updateContentViewConstraints() {

        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    public func layout(with targetSize: CGSize, verticalFittingPriority: UILayoutPriority) -> CGSize {

        widthConstraint.constant = targetSize.width

        let target = CGSize(width: targetSize.width, height: 1)
        let size = contentView.systemLayoutSizeFitting(target,
                                                       withHorizontalFittingPriority: .required,
                                                       verticalFittingPriority: verticalFittingPriority)
        return size
    }
}
