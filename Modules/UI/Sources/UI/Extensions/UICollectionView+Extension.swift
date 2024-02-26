//
//  UICollectionView+Extension.swift
//
//
//  Created by Laryssa Castagnoli on 23/02/24.
//

import UIKit
import Foundation

extension UICollectionView {

    public func register<Element: UICollectionViewCell>(class: Element.Type) {

        register(Element.self, forCellWithReuseIdentifier: Element.reuseIdentifier)
    }

    public func dequeue<Element: UICollectionViewCell>(_ cell: Element.Type, at indexPath: IndexPath) -> Element {

        // swiftlint:disable:next force_cast
        dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as! Element
    }
}

extension UICollectionReusableView {
    public class var reuseIdentifier: String { String(describing: self) }
}
