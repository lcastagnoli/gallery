//
//  HeaderViewModel.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 26/02/24.
//

struct HeaderViewModel {

    private (set) var image: String
    private (set) var genres: [String]?
    private (set) var title: String?

    init(image: String, genres: [String]? = nil, title: String? = nil) {
        self.image = image
        self.genres = genres
        self.title = title
    }
}
