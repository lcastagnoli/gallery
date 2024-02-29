//
//  String+Extension.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 18/02/24.
//

import Foundation

public protocol Defaultable {

    static var defaultValue: Self { get }
}

extension String: Defaultable {

    var localized: String { String(localized: String.LocalizationValue(self)) }
    public static var defaultValue: String { return "" }
}

extension Optional where Wrapped: Defaultable {

    public var unwrapped: Wrapped { self ?? .defaultValue }
}

extension Optional where Wrapped == String {

    public var isNilOrEmpty: Bool {

        guard let self = self, !self.isEmpty else { return true }
        return false
    }
}
