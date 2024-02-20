//
//  APIClient.swift
//
//
//  Created by Laryssa Castagnoli on 16/02/24.
//

import Foundation
import Combine

public protocol ServiceProtocol: AnyObject { }

public protocol APIClientProtocol {

    func request<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<T, Error>
}

public final class APIClient {

    // MARK: Properties
    private let session: URLSession
    private let decoder = JSONDecoder()

    // MARK: Initializers
    public init(session: URLSession) {

        self.session = session
    }
}

// MARK: - APIClientRequestable
extension APIClient: APIClientProtocol {

    public func request<T>(_ urlRequest: URLRequest) -> AnyPublisher<T, Error> where T: Decodable {

        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result
            }
            .decodeResponse(type: T.self, decoder: decoder)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
