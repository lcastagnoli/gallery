//
//  SectionViewModel.swift
//
//
//  Created by Laryssa Castagnoli on 21/02/24.
//

public final class SectionViewModel {

    public let title: String
    public let index: Int
    public let items: [CardViewModel?]

    public init(title: String, items: [CardViewModel?], index: Int) {
        self.title = title
        self.items = items
        self.index = index
    }
}
