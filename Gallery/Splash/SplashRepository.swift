//
//  SplashRepository.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 19/02/24.
//

import Combine
import Network
import Persistence

protocol SplashRepositoryProtocol {

    func startGuestSession() -> AnyPublisher<Guest, Error>
    func save(session: String)
}

final class SplashRepository {

    // MARK: Properties
    private let service: AuthenticationServiceProtocol
    private let security: SecurityProtocol

    // MARK: Initializers
    init(service: AuthenticationServiceProtocol, security: SecurityProtocol) {

        self.service = service
        self.security = security
    }
}

// MARK: - SplashRepositoryProtocol
extension SplashRepository: SplashRepositoryProtocol {

    func startGuestSession() -> AnyPublisher<Guest, Error> {
        return service.startGuestSession().eraseToAnyPublisher()
    }

    func save(session: String) {
        security.save(session, key: SecurityKey.guestSession.rawValue)
    }
}
