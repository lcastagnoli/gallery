//
//  AuthenticationService.swift
//
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import Combine
import Foundation

public protocol AuthenticationServiceProtocol: ServiceProtocol {

    func startGuestSession() -> AnyPublisher<Guest, Error>
}

public final class AuthenticationService: AuthenticationServiceProtocol {

    // MARK: Properties
    private let client: APIClientProtocol

    // MARK: Initializers
    public init(client: APIClientProtocol) {

        self.client = client
    }

    public func startGuestSession() -> AnyPublisher<Guest, Error> {

        let urlRequest = AuthenticationRouter.guest.asURLRequest()
        return client.request(urlRequest).eraseToAnyPublisher()
    }
}
