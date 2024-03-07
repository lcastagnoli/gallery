//
//  PlayerViewModel.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 29/02/24.
//
import Foundation

protocol PlayerViewModelProtocol {

    var videoUrl: URL { get }
}

final class PlayerViewModel {

    struct Dependencies {

        let url: URL
    }

    // MARK: Properties
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - PlayerViewModelProtocol
extension PlayerViewModel: PlayerViewModelProtocol {

    var videoUrl: URL { dependencies.url }
}
