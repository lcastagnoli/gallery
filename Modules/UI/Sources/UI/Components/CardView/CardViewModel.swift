//
//  CardViewModel.swift
//
//
//  Created by Laryssa Castagnoli on 22/02/24.
//

public final class CardViewModel {

    public let image: String
    public let index: Int

    public init(image: String?, index: Int) {
        self.image = image ?? ""
        self.index = index
    }
}
