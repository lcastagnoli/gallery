//
//  PersistedMovie.swift
//
//
//  Created by Laryssa Castagnoli on 24/02/24.
//
import RealmSwift

final public class PersistedMovie: Object {

    @Persisted public var id: Int
    @Persisted public var posterPath: String

    public convenience init(id: Int, posterPath: String) {
        self.init()

        self.id = id
        self.posterPath = posterPath
    }
}
