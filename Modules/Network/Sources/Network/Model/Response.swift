//
//  Response.swift
//
//
//  Created by Laryssa Castagnoli on 22/02/24.
//

import Foundation

// MARK: - Response
public struct Response: Decodable {

    public let page: Int?
    public let results: [Movie]?
    public let totalPages, totalResults: Int?
}
