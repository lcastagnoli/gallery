//
//  SplashRepository.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 19/02/24.
//

import Combine
import GalleryNetwork

protocol SplashRepositoryProtocol {

    func startGuestSession() -> AnyPublisher<Guest, Error>
}

final class SplashRepository {

    // MARK: Properties
    private let service: SplashServiceProtocol

    // MARK: Initializers
    init(service: SplashServiceProtocol) {

        self.service = service
    }
}

// MARK: - HomeRepositoryProtocol
extension SplashRepository: SplashRepositoryProtocol {

    func startGuestSession() -> AnyPublisher<Guest, Error> {

        return service.startGuestSession().eraseToAnyPublisher()
    }
}
