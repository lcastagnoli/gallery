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

    func getMovie(id: Int) -> AnyPublisher<Movie, Error>
}

final class DetailsRepository {

    // MARK: Properties
    private let service: MovieServiceProtocol

    // MARK: Initializers
    init(service: MovieServiceProtocol) {

        self.service = service
    }
}

// MARK: - ListRepositoryProtocol
extension DetailsRepository: DetailsRepositoryProtocol {

    func getMovie(id: Int) -> AnyPublisher<Movie, Error> {
        return service.getMovie(by: id).eraseToAnyPublisher()
    }
}

