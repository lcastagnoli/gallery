//
//  DataSheetViewModel.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 28/02/24.
//

struct DataSheetViewModel {

    private (set) var title: String?
    private (set) var description: String?

    init(title: String? = nil,
         description: String? = nil) {
        self.title = title
        self.description = description
    }
}
