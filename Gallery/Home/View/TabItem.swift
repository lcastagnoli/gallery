//
//  TabItem.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import UIKit

extension UITabBarItem {

    public enum Style: Int {

        case list
        case favorites
        case myList
    }

    public var imageName: String {

        switch self {
        case .list:
            return ""
        case .favorites:
            return ""
        case .myList:
            return ""
        }
    }
}
