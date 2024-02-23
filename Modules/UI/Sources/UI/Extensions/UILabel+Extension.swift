//
//  UILabel+Extension.swift
//
//
//  Created by Laryssa Castagnoli on 21/02/24.
//

import UIKit
import Foundation

extension UILabel: Styleable {

    public enum Style: Int {

        case title

        var font: UIFont {

            switch self {
            case .title:
                return UIFont.boldSystemFont(ofSize: 16.0)
            }
        }

        var textColor: UIColor {

            switch self {

            case .title:
                return .white
            }
        }
    }

    public func style(as style: Style) {

        font = style.font
        textColor = style.textColor
    }

    public convenience init(style: Style) {

        self.init()
        self.style(as: style)
    }
}
