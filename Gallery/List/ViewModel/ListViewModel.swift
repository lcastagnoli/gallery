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
    func details(section: Int, index: Int)
}

final class ListViewModel {

    enum Result {

        case details(Int)
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
    private var sections: [Response] = []

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

    private func handle(with popular: Response,
                        topRated: Response,
                        upcoming: Response,
                        nowPlaying: Response) {

        sections = [popular, topRated, nowPlaying, upcoming]
        items.append(contentsOf: [SectionViewModel(title: TranslationKeys.popular.localized,
                                                   items: createCardsBySection(popular.results),
                                                   index: .zero),
                                  SectionViewModel(title: TranslationKeys.topRated.localized,
                                                   items: createCardsBySection(topRated.results),
                                                   index: 1),
                                  SectionViewModel(title: TranslationKeys.nowPlaying.localized,
                                                   items: createCardsBySection(nowPlaying.results),
                                                   index: 2),
                                  SectionViewModel(title: TranslationKeys.upcoming.localized,
                                                   items: createCardsBySection(upcoming.results),
                                                   index: 3)])
    }

    private func createCardsBySection(_ results: [Network.Movie]) -> [CardViewModel] {
        return results.enumerated().compactMap { (index, item) in
            CardViewModel(image: item.posterPath, index: index)
        }
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

    func details(section: Int, index: Int) {

        guard let movie = sections[safe: section]?.results[index] else { return }
        dependencies.navigation?.list(didFinish: .details(movie.id))
    }
}
