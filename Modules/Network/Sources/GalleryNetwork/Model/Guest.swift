//
//  Guest.swift
//
//
//  Created by Laryssa Castagnoli on 16/02/24.
//

import Foundation

// MARK: - Guest
public struct Guest {

    public let guestSessionId: String

    public init(guestSessionId: String?) {

        self.guestSessionId = guestSessionId ?? ""
    }
}

// MARK: - Decodable
extension Guest: Decodable {

    enum CodingKeys: String, CodingKey {
        case guestSessionId = "guest_session_id"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let guestSessionId = try values.decode(String.self, forKey: .guestSessionId)

        self.init(guestSessionId: guestSessionId)
    }
}
