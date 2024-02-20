//
//  Publisher+Extension.swift
//
//
//  Created by Laryssa Castagnoli on 20/02/24.
//

import Combine
import Foundation

extension Publisher {

    typealias OutputData = (data: Data, response: URLResponse)
    func decodeResponse<Item, Coder>(type: Item.Type,
                                     decoder: Coder) -> Publishers.Decode<Publishers.TryMap<Self, Data>, Item, Coder> where Coder: TopLevelDecoder,  Self.Output == OutputData {

        return self
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: type, decoder: decoder)
    }
}
