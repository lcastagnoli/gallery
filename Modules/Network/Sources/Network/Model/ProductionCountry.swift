//
//  ProductionCountry.swift
//
//
//  Created by Laryssa Castagnoli on 26/02/24.
//
public struct ProductionCountry: Decodable {

    public let name: String?

    enum CodingKeys: String, CodingKey {
        case name
    }
}
