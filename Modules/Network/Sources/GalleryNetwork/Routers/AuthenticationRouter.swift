//
//  AuthenticationRouter.swift
//
//
//  Created by Laryssa Castagnoli on 19/02/24.
//

import Foundation
enum AuthenticationRouter: URLRequestCreator {

    case guest

    var baseURL: URL { Environment.baseUrl }

    var method: Method {

        switch self {

        case .guest:
            return .get
        }
    }

    var path: String {

        switch self {

        case .guest:
            return "authentication/guest_session/new"
        }
    }
}
