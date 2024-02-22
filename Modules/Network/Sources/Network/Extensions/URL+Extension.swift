//
//  URL+Extension.swift
//
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import Foundation

extension URL {

    func appending(queries: [String: String]) -> URL? {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        queries.forEach { (key: String, value: String) in
            queryItems.append(.init(name: key, value: value))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
