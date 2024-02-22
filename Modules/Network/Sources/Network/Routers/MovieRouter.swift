//
//  MovieRouter.swift
//
//
//  Created by Laryssa Castagnoli on 22/02/24.
//

import Foundation
enum MovieRouter: URLRequestCreator {

    case popular

    var baseURL: URL { Environment.baseUrl }

    var method: Method {

        switch self {

        case .popular:
            return .get
        }
    }

    var path: String {

        switch self {

        case .popular:
            return "movie/popular"
        }
    }
}
