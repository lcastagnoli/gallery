//
//  HomeRepository.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 19/02/24.
//

import Combine
import GalleryNetwork

protocol HomeRepositoryProtocol {

    func startGuestSession() -> AnyPublisher<Guest, Error>
}

final class HomeRepository {

    // MARK: Properties
    private let service: HomeServiceProtocol

    // MARK: Initializers
    init(service: HomeServiceProtocol) {

        self.service = service
    }
}

// MARK: - HomeRepositoryProtocol
extension HomeRepository: HomeRepositoryProtocol {

    func startGuestSession() -> AnyPublisher<Guest, Error> {

        return service.startGuestSession().eraseToAnyPublisher()
    }
}
