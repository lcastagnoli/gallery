//
//  PaddingLabel.swift
//
//
//  Created by Laryssa Castagnoli on 27/02/24.
//

import UIKit
import Foundation

public final class PaddingLabel: UILabel {

    public var edgeInset: UIEdgeInsets = .zero

    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: edgeInset.top,
                                       left: edgeInset.left,
                                       bottom: edgeInset.bottom,
                                       right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }

    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right,
                      height: size.height + edgeInset.top + edgeInset.bottom)
    }
}
