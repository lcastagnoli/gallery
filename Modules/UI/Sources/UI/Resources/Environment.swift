//
//  Environment.swift
//
//
//  Created by Laryssa Castagnoli on 22/02/24.
//

import Foundation

public enum Environment {

    public static var baseImageUrl: URL {

        guard
            let string = Bundle.main.object(forInfoDictionaryKey: "baseImageUrl") as? String,
            let url = URL(string: string) else {

            fatalError("Missing InfoPlist BaseURL")
        }
        return url
    }
}
