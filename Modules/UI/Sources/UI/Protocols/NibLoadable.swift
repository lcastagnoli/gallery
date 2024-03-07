//
//  NibLoadable.swift
//
//
//  Created by Laryssa Castagnoli on 28/02/24.
//

import UIKit

public protocol NibLoadable {

    func loadNib()
}

extension NibLoadable where Self: UIView {

    public func loadNib() {

        loadNib(bundle: .main)
    }
}
