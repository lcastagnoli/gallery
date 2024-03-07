//
//  MovieService.swift
//
//
//  Created by Laryssa Castagnoli on 22/02/24.
//

import Combine
import Foundation

public protocol MovieServiceProtocol: ServiceProtocol {

    func getPopularMovies() -> AnyPublisher<Response, Error>
    func getUpcomingMovies() -> AnyPublisher<Response, Error>
    func getTopRatedMovies() -> AnyPublisher<Response, Error>
    func getNowPlayingMovies() -> AnyPublisher<Response, Error>
    func getMovie(by id: Int) -> AnyPublisher<Movie, Error>
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

    public func getPopularMovies() -> AnyPublisher<Response, Error> {
        let urlRequest = MovieRouter.popular.asURLRequest()
        return client.request(urlRequest).eraseToAnyPublisher()
    }

    public func getUpcomingMovies() -> AnyPublisher<Response, Error> {
        let urlRequest = MovieRouter.upcoming.asURLRequest()
        return client.request(urlRequest).eraseToAnyPublisher()
    }

    public func getTopRatedMovies() -> AnyPublisher<Response, Error> {
        let urlRequest = MovieRouter.topRated.asURLRequest()
        return client.request(urlRequest).eraseToAnyPublisher()
    }

    public func getNowPlayingMovies() -> AnyPublisher<Response, Error> {
        let urlRequest = MovieRouter.nowPlaying.asURLRequest()
        return client.request(urlRequest).eraseToAnyPublisher()
    }

    public func getMovie(by id: Int) -> AnyPublisher<Movie, Error> {
        let urlRequest = MovieRouter.movie(id).asURLRequest()
        return client.request(urlRequest).eraseToAnyPublisher()
    }
}
