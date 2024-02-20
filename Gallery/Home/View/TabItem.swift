//
//  TabItem.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import UIKit

enum TabItemType {

    case list
    case favorites

    var image: String {

        switch self {
        case .list:
            return Images.home
        case .favorites:
            return Images.check
        }
    }

    var title: String {

        switch self {
        case .list:
            return TranslationKeys.home.localized
        case .favorites:
            return TranslationKeys.favorites.localized
        }
    }

    var tag: Int {

        switch self {
        case .list:
            return 0
        case .favorites:
            return 1
        }
    }

    var viewController: UIViewController {

        switch self {
        case .list:
            return UINavigationController(rootViewController: ListViewController())
        case .favorites:
            return UINavigationController(rootViewController: FavoritesViewController())
        }
    }
}
