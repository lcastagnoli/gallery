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
        case tab

        var font: UIFont {

            switch self {
            case .play,
                 .favorite:
                return UIFont.boldSystemFont(ofSize: 16.0)
            case .tab:
                return UIFont.systemFont(ofSize: 16.0)
            }
        }

        var textColor: UIColor {

            switch self {

            case .play,
                 .favorite,
                 .tab:
                return .lightGray
            }
        }

        var selectedTextColor: UIColor {

            switch self {

            case .play,
                 .favorite:
                return .lightGray
            case .tab:
                return .white
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
            default:
                return .zero
            }
        }

        var borderWidth: CGFloat {

            switch self {
            case .favorite,
                 .play:
                return 1.0
            default:
                return .zero
            }
        }

        var borderColor: UIColor {

            switch self {
            case .favorite,
                 .play:
                return .white
            default:
                return .clear
            }
        }
    }

    public func style(as style: Style) {

        setTitleColor(style.textColor, for: .normal)
        setTitleColor(style.selectedTextColor, for: .selected)
        titleLabel?.font =  style.font
        backgroundColor = style.backgroundColor
        layer.cornerRadius = style.cornerRadius
        clipsToBounds = style.cornerRadius > .zero
        layer.borderColor = style.borderColor.cgColor
        layer.borderWidth = style.borderWidth
    }

    public convenience init(style: Style) {

        self.init()
        self.style(as: style)
    }

    public convenience init(as style: UIButton.Style,
                            title: String,
                            tag: Int,
                            buttonInsets: UIEdgeInsets = .zero,
                            selected: Bool = false) {

        self.init()
        self.style(as: style)
        self.tag = tag
        setTitle(title, for: .normal)
        titleEdgeInsets = buttonInsets
        self.isSelected = selected
    }
}
