//
//  SearchHistoryRepositoryImpl.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//


import Foundation

final class SearchHistoryRepositoryImpl: SearchHistoryRepository {
    private let userDefaultsKey = "search_history"
    private let limit = 20

    var history: [String] {
        UserDefaults.standard.stringArray(forKey: userDefaultsKey) ?? []
    }

    func add(query: String) {
        var history = self.history
        if let idx = history.firstIndex(of: query) {
            history.remove(at: idx)
        }
        history.insert(query, at: 0)
        if history.count > limit {
            history = Array(history.prefix(limit))
        }
        UserDefaults.standard.set(history, forKey: userDefaultsKey)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}
