//
//  TabItem.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import UIKit
import GalleryNavigation

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

    var coordinator: Presentable {

        switch self {
        case .list:
            let navigation = UINavigationController()
            return ListCoordinator(navigation: navigation)
        case .favorites:
            let navigation = UINavigationController()
            return FavoritesCoordinator(navigation: navigation)
        }
    }
}
