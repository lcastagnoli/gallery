//
//  DetailsRepository.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 26/02/24.
//

import Combine
import Network
import Persistence

protocol DetailsRepositoryProtocol {

    var favorited: Bool { get }
    func getMovie() -> AnyPublisher<Movie, Error>
    func tapFavorite(posterPath: String)
}

final class DetailsRepository {

    // MARK: Properties
    private let service: MovieServiceProtocol
    private let persistence: PersistenceManagerProtocol
    private let movieId: Int

    // MARK: Initializers
    init(service: MovieServiceProtocol, persistence: PersistenceManagerProtocol, movieId: Int) {

        self.service = service
        self.persistence = persistence
        self.movieId = movieId
    }
}

// MARK: - ListRepositoryProtocol
extension DetailsRepository: DetailsRepositoryProtocol {

    var favorited: Bool { persistence.contains(type: PersistedMovie.self, id: movieId) }

    func getMovie() -> AnyPublisher<Movie, Error> {
        return service.getMovie(by: movieId).eraseToAnyPublisher()
    }

    func tapFavorite(posterPath: String) {

        if favorited {
            persistence.delete(key: movieId, as: PersistedMovie.self)
        } else {
            let persistedMovie = PersistedMovie(id: movieId, posterPath: posterPath)
            persistence.save(persistedMovie)
        }
    }
}
