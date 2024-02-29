//
//  SegmentViewModel.swift
//  
//
//  Created by Laryssa Castagnoli on 28/02/24.
//

public final class SegmentViewModel {

    let title: String
    let selected: Bool
    let index: Int

    public init(title: String, selected: Bool = false, index: Int) {
        self.title = title
        self.selected = selected
        self.index = index
    }
}
