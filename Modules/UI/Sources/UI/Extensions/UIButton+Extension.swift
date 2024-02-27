//
//  UIButton+Extension.swift
//
//
//  Created by Laryssa Castagnoli on 27/02/24.
//

import UIKit

extension UIButton: Styleable {

    public enum Style: Int {

        case play
        case favorite

        var font: UIFont {

            switch self {
            case .play,
                 .favorite:
                return UIFont.boldSystemFont(ofSize: 16.0)
            }
        }

        var textColor: UIColor {

            switch self {

            case .play,
                 .favorite:
                return .lightGray
            }
        }

        var backgroundColor: UIColor {

            switch self {
            case .play:
                return .white
            default:
                return .clear
            }
        }

        var cornerRadius: CGFloat {

            switch self {
            case .favorite,
                .play:
                return 8.0
            }
        }

        var borderWidth: CGFloat {

            switch self {
            case .favorite,
                .play:
                return 1.0
            }
        }

        var borderColor: UIColor {

            switch self {
            case .favorite,
                 .play:
                return .white
            }
        }
    }

    public func style(as style: Style) {

        setTitleColor(style.textColor, for: .normal)
        titleLabel?.font =  style.font
        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius
        clipsToBounds = style.cornerRadius > .zero
        layer.borderColor = style.borderColor.cgColor
        layer.borderWidth = style.borderWidth
        titleLabel?.isUserInteractionEnabled = true
    }

    public convenience init(style: Style) {

        self.init()
        self.style(as: style)
    }
}
