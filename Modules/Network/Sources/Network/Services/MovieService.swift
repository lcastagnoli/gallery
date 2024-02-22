//
//  MovieService.swift
//
//
//  Created by Laryssa Castagnoli on 22/02/24.
//

import Combine
import Foundation

public protocol MovieServiceProtocol: ServiceProtocol {

    func getPopularMovies() -> AnyPublisher<ResponseList, Error>
}

public final class MovieService: MovieServiceProtocol {

    // MARK: Properties
    private let client: APIClientProtocol

    // MARK: Initializers
    public init(client: APIClientProtocol) {

        self.client = client
    }

    public func getPopularMovies() -> AnyPublisher<ResponseList, Error> {

        let urlRequest = MovieRouter.popular.asURLRequest()
        return client.request(urlRequest).eraseToAnyPublisher()
    }
}
