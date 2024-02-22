//
//  Styleable.swift
//
//
//  Created by Laryssa Castagnoli on 21/02/24.
//

import Foundation

public protocol Styleable {

    associatedtype Style

    func style(as style: Style)
}
