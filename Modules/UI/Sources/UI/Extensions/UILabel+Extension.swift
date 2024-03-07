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
        case genre
        case description
        case content

        var font: UIFont {

            switch self {
            case .title:
                return UIFont.boldSystemFont(ofSize: 16.0)
            case .genre:
                return UIFont.systemFont(ofSize: 11)
            case .description:
                return UIFont.systemFont(ofSize: 13)
            case .content:
                return UIFont.systemFont(ofSize: 15)
            }
        }

        var textColor: UIColor {

            switch self {

            case .title,
                 .genre,
                 .description,
                 .content:
                return .white
            }
        }

        var backgroundColor: UIColor {

            switch self {
            case .genre:
                return .white.withAlphaComponent(0.5)
            default:
                return .clear
            }
        }

        var cornerRadius: CGFloat {

            switch self {
            case .genre:
                return 8.0
            default:
                return .zero
            }
        }
    }

    public func style(as style: Style) {

        font = style.font
        textColor = style.textColor
        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius
        clipsToBounds = style.cornerRadius > .zero
    }

    public convenience init(style: Style) {

        self.init()
        self.style(as: style)
    }
}
