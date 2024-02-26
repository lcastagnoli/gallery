//
//  MovieRouter.swift
//
//
//  Created by Laryssa Castagnoli on 22/02/24.
//

import Foundation
enum MovieRouter: URLRequestCreator {

    case popular
    case nowPlaying
    case topRated
    case upcoming
    case movie(Int)

    var baseURL: URL { Environment.baseUrl }

    var method: Method {

        switch self {

        case .popular,
             .upcoming,
             .topRated,
             .nowPlaying,
             .movie:
            return .get
        }
    }

    var path: String {

        switch self {

        case .popular:
            return "movie/popular"
        case .nowPlaying:
            return "movie/now_playing"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case let .movie(id):
            return "movie/\(id)"
        }
    }
}
