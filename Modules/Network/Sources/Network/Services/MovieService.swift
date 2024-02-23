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
    func getUpcomingMovies() -> AnyPublisher<ResponseList, Error>
    func getTopRatedMovies() -> AnyPublisher<ResponseList, Error>
    func getNowPlayingMovies() -> AnyPublisher<ResponseList, Error>
}

public final class MovieService {

    // MARK: Properties
    private let client: APIClientProtocol

    // MARK: Initializers
    public init(client: APIClientProtocol) {

        self.client = client
    }
}

// MARK: MovieServiceProtocol
extension MovieService: MovieServiceProtocol {

    public func getPopularMovies() -> AnyPublisher<ResponseList, Error> {
        let urlRequest = MovieRouter.popular.asURLRequest()
        return client.request(urlRequest).eraseToAnyPublisher()
    }

    public func getUpcomingMovies() -> AnyPublisher<ResponseList, Error> {
        let urlRequest = MovieRouter.upcoming.asURLRequest()
        return client.request(urlRequest).eraseToAnyPublisher()
    }

    public func getTopRatedMovies() -> AnyPublisher<ResponseList, Error> {
        let urlRequest = MovieRouter.topRated.asURLRequest()
        return client.request(urlRequest).eraseToAnyPublisher()
    }

    public func getNowPlayingMovies() -> AnyPublisher<ResponseList, Error> {
        let urlRequest = MovieRouter.nowPlaying.asURLRequest()
        return client.request(urlRequest).eraseToAnyPublisher()
    }
}
