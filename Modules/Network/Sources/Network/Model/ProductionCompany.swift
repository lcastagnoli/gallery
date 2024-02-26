//
//  ProductionCompany.swift
//
//
//  Created by Laryssa Castagnoli on 26/02/24.
//

public struct ProductionCompany: Decodable {

    public let id: Int?
    public let logoPath: String?
    public let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
