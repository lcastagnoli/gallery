//
//  TabItem.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import UIKit

extension UITabBarItem {

    convenience init(type: TabItemType) {

        self.init(title: type.title, image: UIImage(named: type.image), tag: type.tag)
    }
}

enum TabItemType {

    case list
    case favorites

    public var image: String {

        switch self {
        case .list:
            return Images.home
        case .favorites:
            return Images.check
        }
    }

    public var title: String {

        switch self {
        case .list:
            return String(localized: String.LocalizationValue(TranslationKeys.home))
        case .favorites:
            return String(localized: String.LocalizationValue(TranslationKeys.favorites))
        }
    }

    public var tag: Int {

        switch self {
        case .list:
            return 0
        case .favorites:
            return 1
        }
    }

    public var viewController: UIViewController {

        switch self {
        case .list:
            return ListViewController()
        case .favorites:
            return FavoritesViewController()
        }
    }
}
