//
//  SectionViewModel.swift
//
//
//  Created by Laryssa Castagnoli on 21/02/24.
//

public final class SectionViewModel {

    public var title: String
    public var index: Int
    public var items: [CardViewModel?]

    public init(title: String, items: [CardViewModel?], index: Int) {
        self.title = title
        self.items = items
        self.index = index
    }
}
