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

protocol DetailsNavigationDelegate: AnyObject {

    func details(didFinish result: DetailsViewModel.Result)
}

protocol DetailsViewModelProtocol {

    var loadingPublisher: Published<Bool>.Publisher { get }
    var errorPublisher: Published<ErrorViewModel?>.Publisher { get }
    var headerPublisher: Published<HeaderViewModel?>.Publisher { get }
    var segmentViewModels: [SegmentViewModel] { get }
    var dataSheetViewModel: DataSheetViewModel? { get }
    var cardViewModels: [CardViewModel] { get }

    func getMovie()
    func tapFavorite()
    func didSelect(recommended index: Int)
    func watch()
}

final class DetailsViewModel {

    enum Result {

        case recommended(Int)
        case watch(URL)
    }

    struct Dependencies {

        weak var navigation: DetailsNavigationDelegate?
        let repository: DetailsRepositoryProtocol
    }

    // MARK: Constants
    private enum Constants {
        static let acting = "Acting"
        static let director = "Director"
        static let youtube = "YouTube"
    }

    // MARK: Properties
    private let dependencies: Dependencies
    private var cancellables = Set<AnyCancellable>()
    @Published private var loading: Bool = false
    @Published private var error: ErrorViewModel?
    @Published private var headerViewModel: HeaderViewModel?
    private (set) var dataSheetViewModel: DataSheetViewModel?
    private (set) var cardViewModels: [CardViewModel] = []
    private var movie: Movie?

    init(dependencies: Dependencies) {

        self.dependencies = dependencies
    }

    private func handle(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            self.error = ErrorViewModel(title: TranslationKeys.error.localized, text: error.localizedDescription)
        case .finished:
            break
        }
    }

    private func handle(_ result: Movie) {

        movie = result
        let genres = result.genres?.compactMap { $0.name }
        let hasVideo = movie?.videos?.results?.first(where: { $0.site == Constants.youtube }) != nil
        headerViewModel = HeaderViewModel(image: result.posterPath,
                                          genres: genres,
                                          title: result.title,
                                          description: result.overview,
                                          favorited: dependencies.repository.favorited,
                                          hasVideo: hasVideo)
        dataSheetViewModel = DataSheetViewModel(title: TranslationKeys.datasheet.localized,
                                                description: buildContent(result))
        cardViewModels = createCards(result.recommendations?.results)
        loading = false
    }

    private func createCards(_ results: [Movie]?) -> [CardViewModel] {
        guard let results else { return [] }
        return results.enumerated().compactMap { (index, item) in
            CardViewModel(image: item.posterPath, index: index)
        }
    }

    private func buildContent(_ movie: Movie) -> String {

        let genres = movie.genres?.compactMap { $0.name }.joined(separator: ", ")
        let countries = movie.productionCountries?.compactMap { $0.name }.joined(separator: ", ")
        let actors = movie.credits?.cast?
            .filter { $0.knownForDepartment == Constants.acting }
            .compactMap { $0.name }.joined(separator: ", ")
        let director = movie.credits?.crew?
            .filter { $0.job == Constants.director }
            .compactMap { $0.name }.joined(separator: ", ")

        return """
\(TranslationKeys.originalTitle.localized): \(movie.originalTitle.unwrapped)
\(TranslationKeys.genre.localized): \(genres.unwrapped)
\(TranslationKeys.productionYear.localized): \(movie.releaseDate.unwrapped)
\(TranslationKeys.country.localized): \(countries.unwrapped)
\(TranslationKeys.director.localized): \(director.unwrapped)
\(TranslationKeys.actors.localized): \(actors.unwrapped)
"""
    }
}

// MARK: - DetailsViewModelProtocol
extension DetailsViewModel: DetailsViewModelProtocol {

    var segmentViewModels: [SegmentViewModel] {
        [SegmentViewModel(title: TranslationKeys.details.localized.uppercased(), index: 0),
         SegmentViewModel(title: TranslationKeys.recommendations.localized.uppercased(), index: 1)]
    }
    var loadingPublisher: Published<Bool>.Publisher { $loading }
    var headerPublisher: Published<HeaderViewModel?>.Publisher { $headerViewModel }
    var errorPublisher: Published<ErrorViewModel?>.Publisher { $error }

    func getMovie() {

        loading = true
        dependencies.repository.getMovie()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.loading = false
                self?.handle(completion)
            }, receiveValue: { [weak self] response in
                self?.handle(response)
            })
            .store(in: &cancellables)
    }

    func tapFavorite() {

        dependencies.repository.tapFavorite(posterPath: movie?.posterPath ?? "")
        headerViewModel?.changeState(favorited: dependencies.repository.favorited)
    }

    func didSelect(recommended index: Int) {

        guard let recommended = movie?.recommendations?.results?[safe: index] else { return }
        dependencies.navigation?.details(didFinish: .recommended(recommended.id))
    }

    func watch() {

        guard let video = movie?.videos?.results?.first(where: { $0.site == Constants.youtube }),
              let videoUrl = URL(string: "\(Environment.youtubeUrl)\(video.key.unwrapped)") else { return }

        dependencies.navigation?.details(didFinish: .watch(videoUrl))
    }
}
