//
//  CollectionCell.swift
//
//
//  Created by Laryssa Castagnoli on 23/02/24.
//

import UIKit

public final class CollectionCell<View: UIView>: UICollectionViewCell {

    public lazy var view: View = {

        updateContentViewConstraints()

        let view = View()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        return view
    }()

    public override func systemLayoutSizeFitting(
        _ targetSize: CGSize,
        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
        verticalFittingPriority: UILayoutPriority
    ) -> CGSize {

        layout(with: targetSize, verticalFittingPriority: verticalFittingPriority)
    }
}

// MARK: - DynamicHeightCollectionCell
extension CollectionCell: DynamicHeightCollectionCell {

    public static var estimatedHeight: CGFloat {

        let view = View()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutIfNeeded()
        return view.bounds.height
    }
}
