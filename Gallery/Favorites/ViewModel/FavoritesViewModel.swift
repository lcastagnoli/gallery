//
//  FavoritesViewModel.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 24/02/24.
//

import Foundation
import Persistence
import UI

protocol FavoritesViewModelProtocol {

    var itemsPublisher: Published<[CardViewModel]>.Publisher { get }
    func getFavoriteMovies()
}

final class FavoritesViewModel {

    struct Dependencies {

        let persistence: PersistenceManagerProtocol
    }

    // MARK: Properties
    private let dependencies: Dependencies
    private let group = DispatchGroup()
    @Published private var items: [CardViewModel] = []

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - FavoritesViewModelProtocol
extension FavoritesViewModel: FavoritesViewModelProtocol {

    var itemsPublisher: Published<[CardViewModel]>.Publisher { $items }

    func getFavoriteMovies() {

        guard let movies = dependencies.persistence.get(type: PersistedMovie.self) else { return }
        var images: [CardViewModel] = []
        for (index, movie) in movies.enumerated() {

            images.append(CardViewModel(image: movie.posterPath, index: index))
        }
        items = images
    }
}
