//
//  ResponseList.swift
//
//
//  Created by Laryssa Castagnoli on 22/02/24.
//

import Foundation

// MARK: - Response
public struct ResponseList: Decodable {
    public let page: Int
    public let results: [Result]
    public let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
