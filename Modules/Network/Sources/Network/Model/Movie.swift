//
//  Result.swift
//
//
//  Created by Laryssa Castagnoli on 22/02/24.
//

import Foundation

// MARK: - Result
public struct Movie: Decodable {

    public let genres: [Genre]?
    public let id: Int
    public let originalLanguage, originalTitle: String?
    public let posterPath: String?
    public let releaseDate: String?
    public let title, overview: String?
    public let recommendations: Response?
    public let productionCountries: [ProductionCountry]?
    public let credits: Credits?
    public let videos: Videos?

    enum CodingKeys: String, CodingKey {
        case genres, id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case recommendations
        case productionCountries = "production_countries"
        case credits
        case videos
        case overview
    }
}
