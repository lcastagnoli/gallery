//
//  SplashViewModel.swift
//
//
//  Created by Laryssa Castagnoli on 21/02/24.
//

import Foundation
import RealmSwift

public protocol PersistenceManagerProtocol {

    func save<T>(_ value: T) where T: Object
    func delete<T>(key: Int, as type: T.Type) where T: Object
    func get<T>(type: T.Type) -> Results<T>? where T: Object
    func contains<T>(type: T.Type, id: Int) -> Bool where T: Object
    func clear() async throws
}

public final class PersistenceManager: PersistenceManagerProtocol {

    private lazy var realm = try? Realm()

    public init() {}

    public func save<T>(_ value: T) where T: Object {

        try? realm?.write {
            realm?.add(value)
        }
    }

    public func delete<T>(key: Int, as type: T.Type) where T: Object {

        try? realm?.write {
            let toDelete = realm?.object(ofType: type.self, forPrimaryKey: key)
            realm?.delete(toDelete!)
        }
    }

    public func get<T>(type: T.Type) -> Results<T>? where T: Object {

        return realm?.objects(T.self)
    }

    public func contains<T>(type: T.Type, id: Int) -> Bool where T: Object {

        return realm?.objects(T.self).filter("id == %i", id).count ?? .zero > .zero
    }

    public func clear() async throws {

        try await realm?.asyncWrite {
            realm?.deleteAll()
        }
    }
}
