//
//  String+Extension.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 18/02/24.
//

extension String {

    var localized: String { String(localized: String.LocalizationValue(self)) }
}
