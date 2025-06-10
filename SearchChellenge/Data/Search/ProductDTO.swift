//
//  ProductDTO.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import Foundation

struct APIResponse: Decodable {
    let item: ItemSection

    struct ItemSection: Decodable {
        let props: PropsSection
        struct PropsSection: Decodable {
            let pageProps: PagePropsSection
            struct PagePropsSection: Decodable {
                let initialData: InitialDataSection
                struct InitialDataSection: Decodable {
                    let searchResult: SearchResultSection
                    struct SearchResultSection: Decodable {
                        let itemStacks: [ItemStackSection]
                        struct ItemStackSection: Decodable {
                            let items: [ProductDTO]
                        }
                    }
                }
            }
        }
    }
}

struct ProductDTO: Decodable {
    let id: String?
    let name: String?
    let price: Double?
    let image: String?
    let isOutOfStock: Bool?
    let canonicalUrl: String?
    let sellerName: String?
    let averageRating: Double?
    let numberOfReviews: Int?

    var displayPrice: String {
        guard let price = price else { return "N/A" }
        return "$\(price)"
    }
}
