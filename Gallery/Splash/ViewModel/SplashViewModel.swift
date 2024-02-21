//
//  SplashViewModel.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import Combine
import Network
import Foundation

protocol SplashNavigationDelegate: AnyObject {

    func splash(didFinish result: SplashViewModel.Result)
}

protocol SplashViewModelProtocol {

    var loadingPublisher: Published<Bool>.Publisher { get }
    func startGuestSession()
}

final class SplashViewModel {

    enum Result {

        case success
        case error(String)
    }

    struct Dependencies {

        weak var navigation: SplashNavigationDelegate?
        let repository: SplashRepositoryProtocol
    }

    // MARK: Properties
    private let dependencies: Dependencies
    private var cancellables = Set<AnyCancellable>()
    @Published private var loading: Bool = false

    init(dependencies: Dependencies) {

        self.dependencies = dependencies
    }
}

// MARK: - HomeViewModelProtocol
extension SplashViewModel: SplashViewModelProtocol {

    var loadingPublisher: Published<Bool>.Publisher { $loading }

    func startGuestSession() {
        loading = true
        dependencies.repository.startGuestSession()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.loading = false
                if case .failure(let error) = completion {
                    self?.dependencies.navigation?.splash(didFinish: .error(error.localizedDescription))
                }
            }, receiveValue: { [weak self] session in
                self?.loading = false
                self?.dependencies.repository.save(session: session.guestSessionId)
                self?.dependencies.navigation?.splash(didFinish: .success)
            })
            .store(in: &cancellables)
    }
}
