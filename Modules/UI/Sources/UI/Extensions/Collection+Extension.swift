//
//  Collection+Extension.swift
//
//
//  Created by Laryssa Castagnoli on 24/02/24.
//

extension Collection {

    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
