//
//  SearchHistoryRepository.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import Foundation

protocol SearchHistoryRepository {
    var history: [String] { get }
    func add(query: String)
    func clear()
}

