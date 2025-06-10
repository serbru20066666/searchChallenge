//
//  ProductService.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import Foundation

final class ProductService {
    func search(query: String, page: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let urlString = "\(APIConstants.baseSearchURL)?keyword=\(safeQuery)&page=\(page)&sortBy=best_match"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(APIConstants.apiKey, forHTTPHeaderField: "x-rapidapi-key")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 2)))
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                let stacks = apiResponse.item.props.pageProps.initialData.searchResult.itemStacks
                let allItems = stacks.flatMap { $0.items }
                let products = allItems.compactMap { dto -> Product? in
                    guard
                        let id = dto.id,
                        let name = dto.name,
                        let price = dto.price,
                        let image = dto.image,
                        let isOutOfStock = dto.isOutOfStock
                    else { return nil }
                    return Product(
                        id: id,
                        name: name,
                        price: "$\(price)",
                        image: image,
                        sellerName: dto.sellerName,
                        averageRating: dto.averageRating,
                        numberOfReviews: dto.numberOfReviews,
                        isOutOfStock: isOutOfStock,
                        canonicalUrl: dto.canonicalUrl
                    )
                }
                completion(.success(products))
            } catch {
                print("DECODE ERROR: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                }
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
