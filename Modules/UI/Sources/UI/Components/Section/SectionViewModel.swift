//
//  SectionViewModel.swift
//
//
//  Created by Laryssa Castagnoli on 21/02/24.
//

public final class SectionViewModel {

    public var title: String
    public var items: [String]

    public init(title: String, items: [String]) {
        self.title = title
        self.items = items
    }
}
