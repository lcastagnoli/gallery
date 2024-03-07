//
//  FavoritesViewModel.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 24/02/24.
//

import Foundation
import Persistence
import UI

protocol FavoritesNavigationDelegate: AnyObject {

    func favorites(didFinish result: FavoritesViewModel.Result)
}

protocol FavoritesViewModelProtocol {

    var itemsPublisher: Published<[CardViewModel]>.Publisher { get }
    func getFavoriteMovies()
    func didSelect(index: Int)
}

final class FavoritesViewModel {

    enum Result {

        case details(Int)
    }

    struct Dependencies {

        weak var navigation: FavoritesNavigationDelegate?
        let persistence: PersistenceManagerProtocol
    }

    // MARK: Properties
    private let dependencies: Dependencies
    private let group = DispatchGroup()
    @Published private var items: [CardViewModel] = []
    private var movies: [PersistedMovie] = []

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - FavoritesViewModelProtocol
extension FavoritesViewModel: FavoritesViewModelProtocol {

    var itemsPublisher: Published<[CardViewModel]>.Publisher { $items }

    func getFavoriteMovies() {

        items = createCards()
    }

    private func createCards() -> [CardViewModel] {
        guard let movies = dependencies.persistence.get(type: PersistedMovie.self) else { return [] }
        self.movies = Array(movies)
        return movies.enumerated().compactMap { (index, item) in
            CardViewModel(image: item.posterPath, index: index)
        }
    }

    func didSelect(index: Int) {

        guard let movieId = movies[safe: index]?.id else { return }
        dependencies.navigation?.favorites(didFinish: .details(movieId))
    }
}
