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

    func startGuestSession()
}

final class SplashViewModel {

    // MARK: Properties
    private let repository: SplashRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    init(repository: SplashRepositoryProtocol) {

        self.repository = repository
    }
}

// MARK: - HomeViewModelProtocol
extension SplashViewModel: SplashViewModelProtocol {

    func startGuestSession() {
        repository.startGuestSession()
                    .receive(on: DispatchSerialQueue.main)
                    .sink(receiveCompletion: { [weak self] completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            print(error)
                        }
                    }, receiveValue: { [weak self] session in
                        
                    })
                    .store(in: &cancellables)
    }
}

