//
//  ListViewModel.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 18/02/24.
//

import Combine
import Network
import Foundation
import UI

protocol ListNavigationDelegate: AnyObject {

    func list(didFinish result: ListViewModel.Result)
}

protocol ListViewModelProtocol {

    var loadingPublisher: Published<Bool>.Publisher { get }
    var itemsPublisher: Published<[SectionViewModel]>.Publisher { get }
    func getPopularMovies()
}

final class ListViewModel {

    enum Result {

        case error(String)
    }

    struct Dependencies {

        weak var navigation: ListNavigationDelegate?
        let repository: ListRepositoryProtocol
    }

    // MARK: Properties
    private let dependencies: Dependencies
    private var cancellables = Set<AnyCancellable>()
    @Published private var loading: Bool = false
    @Published private var items: [SectionViewModel] = []

    init(dependencies: Dependencies) {

        self.dependencies = dependencies
    }
}

// MARK: - ListViewModelProtocol
extension ListViewModel: ListViewModelProtocol {

    var loadingPublisher: Published<Bool>.Publisher { $loading }
    var itemsPublisher: Published<[SectionViewModel]>.Publisher { $items }

    func getPopularMovies() {
        loading = true
        dependencies.repository.getPopularMovies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.loading = false
                if case .failure(let error) = completion {
                    self?.dependencies.navigation?.list(didFinish: .error(error.localizedDescription))
                }
            }, receiveValue: { [weak self] response in
                self?.items.append(SectionViewModel(title: TranslationKeys.popular.localized,
                                                    items: response.results.map { $0.posterPath }))
                self?.loading = false
            })
            .store(in: &cancellables)
    }
}
