//
//  DetailsViewModel.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 26/02/24.
//

import Combine
import UI
import Network
import Foundation

protocol DetailsViewDelegate: AnyObject {

    func details(didFinish result: DetailsViewModel.Result)
}

protocol DetailsViewModelProtocol {

    var loadingPublisher: Published<Bool>.Publisher { get }
    var headerPublisher: Published<HeaderViewModel?>.Publisher { get }

    func getMovie()
    func tapFavorite()
}

final class DetailsViewModel {

    enum Result {

        case error(String)
    }

    struct Dependencies {

        weak var navigation: DetailsViewDelegate?
        let repository: DetailsRepositoryProtocol
    }

    // MARK: Properties
    private let dependencies: Dependencies
    private var cancellables = Set<AnyCancellable>()
    @Published private var loading: Bool = false
    @Published private var headerViewModel: HeaderViewModel?
    private var movie: Movie?

    init(dependencies: Dependencies) {

        self.dependencies = dependencies
    }

    private func handle(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            dependencies.navigation?.details(didFinish: .error(error.localizedDescription))
        case .finished:
            break
        }
    }

    private func handle(_ result: Movie) {

        movie = result
        let genres = result.genres?.compactMap { $0.name }
        headerViewModel = HeaderViewModel(image: result.posterPath,
                                          genres: genres,
                                          title: result.title,
                                          description: result.overview,
                                          favorited: dependencies.repository.favorited)
    }
}

// MARK: - DetailsViewModelProtocol
extension DetailsViewModel: DetailsViewModelProtocol {

    var loadingPublisher: Published<Bool>.Publisher { $loading }
    var headerPublisher: Published<HeaderViewModel?>.Publisher { $headerViewModel }

    func getMovie() {

        loading = true
        dependencies.repository.getMovie()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.loading = false
                self?.handle(completion)
            }, receiveValue: { [weak self] response in
                self?.loading = false
                self?.handle(response)
            })
            .store(in: &cancellables)
    }

    func tapFavorite() {

        dependencies.repository.tapFavorite(posterPath: movie?.posterPath ?? "")
        headerViewModel?.changeState(favorited: dependencies.repository.favorited)
    }
}
