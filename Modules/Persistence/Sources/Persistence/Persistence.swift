//
//  SplashViewModel.swift
//
//
//  Created by Laryssa Castagnoli on 21/02/24.
//

import Foundation

public protocol PersistenceManagerProtocol {

    func save<T>(_ value: T, key: String) where T: Encodable
    func delete(key: String)
    func get<T>(key: String, as type: T.Type) -> T? where T: Decodable
    func contains(key: String) -> Bool
    func clear()
}

public final class PersistenceManager: PersistenceManagerProtocol {

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let userDefaults: UserDefaults? = nil
    private let idenfitier: String = ""

    public func save<T>(_ value: T, key: String) where T: Encodable {

        do {

            let data = try encoder.encode(value)
            userDefaults?.set(data, forKey: key)
        } catch {

            if #unavailable(iOS 13) {

                userDefaults?.set(value, forKey: key)
            }
        }
    }

    public func delete(key: String) {
        userDefaults?.removeObject(forKey: key)
    }

    public func get<T>(key: String, as type: T.Type) -> T? where T: Decodable {

        if let data = userDefaults?.data(forKey: key) {

            return try? decoder.decode(type.self, from: data)
        }

        return userDefaults?.value(forKey: key) as? T
    }

    public func contains(key: String) -> Bool {

        return userDefaults?.value(forKey: key) != nil
    }

    public func clear() {

        userDefaults?.removePersistentDomain(forName: idenfitier)
        userDefaults?.synchronize()
    }
}
