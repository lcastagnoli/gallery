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
    func getMovies()
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
    private let group = DispatchGroup()
    @Published private var loading: Bool = false
    @Published private var items: [SectionViewModel] = []

    init(dependencies: Dependencies) {

        self.dependencies = dependencies
    }

    private func handle(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            dependencies.navigation?.list(didFinish: .error(error.localizedDescription))
        case .finished:
            break
        }
    }

    private func handle(with popular: ResponseList,
                        topRated: ResponseList,
                        upcoming: ResponseList,
                        nowPlaying: ResponseList) {
        let sectionPopular = SectionViewModel(title: TranslationKeys.popular.localized,
                                             items: popular.results.map { $0.posterPath })
        let sectionTopRated = SectionViewModel(title: TranslationKeys.topRated.localized,
                                             items: topRated.results.map { $0.posterPath })
        let sectionNowPlaying = SectionViewModel(title: TranslationKeys.nowPlaying.localized,
                                             items: nowPlaying.results.map { $0.posterPath })
        let sectionUpcoming = SectionViewModel(title: TranslationKeys.upcoming.localized,
                                             items: upcoming.results.map { $0.posterPath })

        items.append(contentsOf: [sectionPopular, sectionTopRated, sectionNowPlaying, sectionUpcoming])
    }
}

// MARK: - ListViewModelProtocol
extension ListViewModel: ListViewModelProtocol {

    var loadingPublisher: Published<Bool>.Publisher { $loading }
    var itemsPublisher: Published<[SectionViewModel]>.Publisher { $items }

    func getMovies() {

        loading = true
        let popularPublisher = dependencies.repository.getPopularMovies()
        let nowPlayingPublisher = dependencies.repository.getNowPlayingMovies()
        let topRatedPublisher = dependencies.repository.getTopRatedMovies()
        let upcomingPublisher = dependencies.repository.getUpcomingMovies()

        Publishers.CombineLatest4(popularPublisher, nowPlayingPublisher, topRatedPublisher, upcomingPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.loading = false
                self?.handle(completion)
            }, receiveValue: { [weak self] popularResponse, nowPlayingResponse, topRatedResponse, upcomingResponse in
                self?.handle(with: popularResponse,
                             topRated: topRatedResponse,
                             upcoming: upcomingResponse,
                             nowPlaying: nowPlayingResponse)
                self?.loading = false
            })
            .store(in: &cancellables)
    }
}
