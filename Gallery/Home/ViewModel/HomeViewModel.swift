//
//  HomeViewModel.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 15/02/24.
//

import Combine
import GalleryNetwork
import Foundation

protocol HomeViewModelProtocol {

    var tabs: [TabItemType] { get }
    func startGuestSession()
}

final class HomeViewModel {

    // MARK: Properties
    private let repository: HomeRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    init(repository: HomeRepositoryProtocol) {

        self.repository = repository
    }
}

// MARK: - HomeViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {

    var tabs: [TabItemType] { [.list, .favorites] }

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
