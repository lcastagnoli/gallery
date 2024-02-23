//
//  UINavigationController+Extension.swift
//
//
//  Created by Laryssa Castagnoli on 23/02/24.
//

import UIKit

extension UINavigationController {

    public convenience init(barStyle style: UINavigationBar.Style) {

        self.init()
        navigationBar.style(as: style)
    }

    public convenience init(rootViewController: UIViewController, style: UINavigationBar.Style) {

        self.init(rootViewController: rootViewController)
        navigationBar.style(as: style)
    }
}
