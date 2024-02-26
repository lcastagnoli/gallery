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
import Persistence

protocol ListNavigationDelegate: AnyObject {

    func list(didFinish result: ListViewModel.Result)
}

protocol ListViewModelProtocol {

    var loadingPublisher: Published<Bool>.Publisher { get }
    var itemsPublisher: Published<[SectionViewModel]>.Publisher { get }
    func getMovies()
    func addFavorite(section: Int, index: Int)
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
    private var sections: [ResponseList] = []

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
        createSectionViewModels([TranslationKeys.popular.localized: popular,
                                 TranslationKeys.topRated.localized: topRated,
                                 TranslationKeys.nowPlaying.localized: nowPlaying,
                                 TranslationKeys.upcoming.localized: upcoming])
        sections = [popular, topRated, nowPlaying, upcoming]
    }

    private func createSectionViewModels(_ sections: [String: ResponseList]) {

        var sectionViewModels: [SectionViewModel] = []
        for (index, item) in sections.enumerated() {

            let section = SectionViewModel(title: item.key,
                                           items: createCardsBySection(item.value.results),
                                           index: index)
            sectionViewModels.append(section)
        }

        items.append(contentsOf: sectionViewModels)
    }

    private func createCardsBySection(_ results: [Network.Result]) -> [CardViewModel] {

        var cards: [CardViewModel] = []
        for (index, result) in results.enumerated() {

            cards.append(CardViewModel(image: result.posterPath, index: index))
        }
        return cards
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

    func addFavorite(section: Int, index: Int) {

        let persistence = PersistenceManager()
        guard let movie = sections[safe: section]?.results[index] else { return }
        let persistedMovie = PersistedMovie(id: movie.id, posterPath: movie.posterPath)
        persistence.save(persistedMovie)
    }
}
