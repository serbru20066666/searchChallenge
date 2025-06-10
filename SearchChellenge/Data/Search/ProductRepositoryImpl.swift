//
//  ProductRepositoryImpl.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import Foundation

final class ProductRepositoryImpl: ProductRepository {
    private let service: ProductService

    init(service: ProductService) {
        self.service = service
    }

    func search(query: String, page: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        service.search(query: query, page: page, completion: completion)
    }
}

