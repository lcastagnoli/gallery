//
//  UIBarButtonItem+Extension.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 27/02/24.
//

import UIKit

extension UIBarButtonItem {

    public static func custom(icon: String, handler: (() -> Void)? = nil) -> UIBarButtonItem {

        let image = UIImage(named: icon)
        return BlockBarButtonItem(image: image, style: .plain, handler: handler)
    }
}

final class BlockBarButtonItem: UIBarButtonItem {

    // MARK: Properties
    private var handler: (() -> Void)?

    // MARK: Initializers
    convenience init(image: UIImage?, style: UIBarButtonItem.Style, handler: (() -> Void)?) {
        self.init(image: image, style: style, target: nil, action: #selector(actionHandler))

        self.target = self
        self.handler = handler
    }

    // MARK: Methods
    @objc private func actionHandler(sender: UIBarButtonItem) {

        handler?()
    }
}
