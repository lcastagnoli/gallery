//
//  ListRepository.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 22/02/24.
//

import Combine
import Network
import Persistence

protocol ListRepositoryProtocol {

    func getPopularMovies() -> AnyPublisher<Response, Error>
    func getUpcomingMovies() -> AnyPublisher<Response, Error>
    func getTopRatedMovies() -> AnyPublisher<Response, Error>
    func getNowPlayingMovies() -> AnyPublisher<Response, Error>
}

final class ListRepository {

    // MARK: Properties
    private let service: MovieServiceProtocol

    // MARK: Initializers
    init(service: MovieServiceProtocol) {

        self.service = service
    }
}

// MARK: - ListRepositoryProtocol
extension ListRepository: ListRepositoryProtocol {

    func getPopularMovies() -> AnyPublisher<Response, Error> {
        return service.getPopularMovies().eraseToAnyPublisher()
    }

    func getUpcomingMovies() -> AnyPublisher<Network.Response, Error> {
        return service.getUpcomingMovies().eraseToAnyPublisher()
    }

    func getTopRatedMovies() -> AnyPublisher<Network.Response, Error> {
        return service.getTopRatedMovies().eraseToAnyPublisher()
    }

    func getNowPlayingMovies() -> AnyPublisher<Network.Response, Error> {
        return service.getNowPlayingMovies().eraseToAnyPublisher()
    }
}
