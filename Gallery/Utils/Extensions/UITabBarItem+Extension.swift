//
//  UITabBarItem+Extension.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 19/02/24.
//

import UIKit

extension UITabBarItem {

    convenience init(type: TabItemType) {

        self.init(title: type.title, image: UIImage(named: type.image), tag: type.tag)
    }
}
