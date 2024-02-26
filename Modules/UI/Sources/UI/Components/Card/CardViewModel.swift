//
//  CardViewModel.swift
//
//
//  Created by Laryssa Castagnoli on 22/02/24.
//

public final class CardViewModel {

    public var image: String
    public var index: Int

    public init(image: String?, index: Int) {
        self.image = image ?? ""
        self.index = index
    }
}
