//
//  Environment.swift
//  Gallery
//
//  Created by Laryssa Castagnoli on 29/02/24.
//

import Foundation

enum Environment {

    static var youtubeUrl: URL {

        guard
            let string = Bundle.main.object(forInfoDictionaryKey: "youtubeUrl") as? String,
            let url = URL(string: string) else {

            fatalError("Missing InfoPlist BaseURL")
        }
        return url
    }

    static var baseImageUrl: URL {

        guard
            let string = Bundle.main.object(forInfoDictionaryKey: "baseImageUrl") as? String,
            let url = URL(string: string) else {

            fatalError("Missing InfoPlist BaseURL")
        }
        return url
    }
}
