//
//  SegmentViewModel.swift
//  
//
//  Created by Laryssa Castagnoli on 28/02/24.
//

public final class SegmentViewModel {

    public let title: String
    public let selected: Bool
    public let index: Int

    public init(title: String, selected: Bool = false, index: Int) {
        self.title = title
        self.selected = selected
        self.index = index
    }
}
