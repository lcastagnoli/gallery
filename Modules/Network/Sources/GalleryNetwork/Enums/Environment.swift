//
//  Environment.swift
//
//
//  Created by Laryssa Castagnoli on 19/02/24.
//

import Foundation

enum Environment {

    static var baseUrl: URL {

        guard
            let string = Bundle.main.object(forInfoDictionaryKey: "baseUrl") as? String,
            let url = URL(string: string) else {

            fatalError("Missing InfoPlist BaseURL")
        }
        return url
    }

    private static var accessToken: String {

        guard
            let accessToken = Bundle.main.object(forInfoDictionaryKey: "accessToken") as? String else {

            fatalError("Missing InfoPlist AccessToken")
        }
        return accessToken
    }

    static var buildHeaders: [String: String]? {

        return ["Authorization": "Bearer \(accessToken)"]
    }
}
