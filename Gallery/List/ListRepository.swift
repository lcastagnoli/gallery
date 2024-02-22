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

    func getPopularMovies() -> AnyPublisher<ResponseList, Error>
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

    func getPopularMovies() -> AnyPublisher<ResponseList, Error> {
        return service.getPopularMovies().eraseToAnyPublisher()
    }
}
