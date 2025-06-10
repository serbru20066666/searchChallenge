//
//  Product.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import Foundation

struct Product: Identifiable {
    let id: String
    let name: String
    let price: String
    let image: String
    let sellerName: String?
    let averageRating: Double?
    let numberOfReviews: Int?
    let isOutOfStock: Bool
    let canonicalUrl: String?
}
