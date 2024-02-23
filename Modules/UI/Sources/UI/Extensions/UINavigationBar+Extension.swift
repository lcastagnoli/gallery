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

        var backgroundColor: UIColor {

            switch self {

            case .black:
                return .black
            }
        }

        var tintColor: UIColor {

            switch self {

            case .black:
                return .white
            }
        }

        var isTranslucent: Bool {

            switch self {

            case .black:
                return false
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
            }
        }

        var shadowImage: UIImage? {

            switch self {

            case .black:
                return nil
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
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        compactAppearance = appearance
    }
}
