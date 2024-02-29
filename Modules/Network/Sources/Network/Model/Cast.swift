//
//  Cast.swift
//
//
//  Created by Laryssa Castagnoli on 29/02/24.
//

import Foundation

public struct Cast: Decodable {

    public let name: String?
    public let knownForDepartment, job: String?

    enum CodingKeys: String, CodingKey {
        case name
        case job
        case knownForDepartment = "known_for_department"
    }
}
