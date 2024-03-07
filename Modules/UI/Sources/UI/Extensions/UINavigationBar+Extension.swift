//
//  UINavigationBar+Extension.swift
//
//
//  Created by Laryssa Castagnoli on 23/02/24.
//

import UIKit

extension UINavigationBar: Styleable {

    public enum Style: Int {

        case black
        case transparent

        var backgroundColor: UIColor {

            switch self {

            case .black:
                return .black
            case .transparent:
                return .clear
            }
        }

        var tintColor: UIColor {

            switch self {

            case .black,
                 .transparent:
                return .white
            }
        }

        var isTranslucent: Bool {

            switch self {

            case .black:
                return false
            case .transparent:
                return true
            }
        }

        var font: UIFont {

            switch self {

            default:
                return .boldSystemFont(ofSize: 18.0)
            }
        }

        var backgroundImage: UIImage? {

            switch self {

            case .black:
                return nil
            default:
                return UIImage()
            }
        }

        var shadowImage: UIImage? {

            switch self {

            case .black:
                return nil
            default:
                return UIImage()
            }
        }
    }

    public func style(as style: Style) {

        let appearance = UINavigationBarAppearance()

        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: style.tintColor,
                                          .font: style.font]
        appearance.largeTitleTextAttributes = [.foregroundColor: style.tintColor]
        appearance.backgroundColor = style.backgroundColor
        appearance.shadowColor = .clear
        appearance.backgroundEffect = nil
        appearance.backgroundImage = style.backgroundImage
        appearance.shadowImage = style.shadowImage

        tintColor = style.tintColor
        isTranslucent = style.isTranslucent
        shadowImage = style.shadowImage

        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        compactAppearance = appearance
    }
}
