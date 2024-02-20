//
//  SplashViewModel.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import Combine
import GalleryNetwork
import Foundation

protocol SplashViewModelProtocol {

    var loadingPublisher: Published<Bool>.Publisher { get }
    func startGuestSession()
}

final class SplashViewModel {

    // MARK: Properties
    private let repository: SplashRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    @Published private var loading: Bool = false

    init(repository: SplashRepositoryProtocol) {

        self.repository = repository
    }
}

// MARK: - HomeViewModelProtocol
extension SplashViewModel: SplashViewModelProtocol {

    var loadingPublisher: Published<Bool>.Publisher { $loading }

    func startGuestSession() {
        loading = true
        repository.startGuestSession()
            .receive(on: DispatchSerialQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.loading = false
                switch completion {
                case .finished: break
                    case .failure(let error): print(error) }
            }, receiveValue: { [weak self] session in
                self?.loading = false
            })
            .store(in: &cancellables)
    }
}
