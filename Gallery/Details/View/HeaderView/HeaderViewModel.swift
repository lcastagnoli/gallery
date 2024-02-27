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
    private (set) var description: String?
    private (set) var favorited: Bool

    init(image: String,
         genres: [String]? = nil,
         title: String? = nil,
         description: String? = nil,
         favorited: Bool = false) {
        self.image = image
        self.genres = genres
        self.title = title
        self.description = description
        self.favorited = favorited
    }

    public mutating func changeState(favorited: Bool) {

        self.favorited = favorited
    }
}
