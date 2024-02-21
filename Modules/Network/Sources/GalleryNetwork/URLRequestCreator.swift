//
//  URLRequestCreator.swift
//
//
//  Created by Laryssa Castagnoli on 19/02/24.
//

import Foundation

protocol URLRequestCreator {

    var baseURL: URL { get }
    var path: String { get }
    var method: Method { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any] { get }
    var queries: [String: String] { get }
}

extension URLRequestCreator {

    var queries: [String: String] { [:] }
    var parameters: [String: Any] { [:] }
    var headers: [String: String]? { Environment.buildHeaders }

    func asURLRequest() -> URLRequest {

        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        switch (method, queries) {

        case (.get, _):
            request.url = request.url?.appending(queries: queries)

        case (.post, let queries):
            request = encode(request: &request, with: queries, and: parameters)
        }
        return request
    }

    private func encode(request: inout URLRequest,
                        with queries: [String: String],
                        and body: [String: Any]?) -> URLRequest {

        if !queries.isEmpty {
            request.url = request.url?.appending(queries: queries)
        }
        if let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) {

            request.httpBody = httpBody
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }

        return request
    }
}
