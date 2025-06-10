//
//  ProductRepository.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import Foundation

protocol ProductRepository {
    func search(query: String, page: Int, completion: @escaping (Result<[Product], Error>) -> Void)
}

