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
    typealias Result = Publishers.TryMap<Self, Data>
    func decodeResponse<Item, Coder: TopLevelDecoder>(
        type: Item.Type,
        decoder: Coder
    ) -> Publishers.Decode<Result, Item, Coder> where Self.Output == OutputData {

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
