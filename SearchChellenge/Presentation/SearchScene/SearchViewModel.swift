//
//  SearchViewModel.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    private let productRepository: ProductRepository
    private let searchHistoryRepository: SearchHistoryRepository

    @Published var products: [Product] = []
    @Published var searchHistory: [String] = []
    @Published var query: String = ""
    @Published var isLoading = false
    @Published var error: String?
    @Published var isShowingHistory = true

    private var currentPage: Int = 1
    private var isLastPage = false
    private var subscriptions = Set<AnyCancellable>()

    init(productRepository: ProductRepository, searchHistoryRepository: SearchHistoryRepository) {
        self.productRepository = productRepository
        self.searchHistoryRepository = searchHistoryRepository
        loadHistory()
    }

    func search() {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty, !isLoading else { return }
        isLoading = true
        currentPage = 1
        isLastPage = false
        productRepository.search(query: query, page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.isLoading = false
                switch result {
                case .success(let products):
                    self.products = products
                    self.searchHistoryRepository.add(query: self.query)
                    self.loadHistory()
                    self.isShowingHistory = false
                    self.isLastPage = products.isEmpty
                case .failure:
                    self.error = Strings.genericError
                }
            }
        }
    }

    func fetchNextPageIfNeeded(currentItem: Product?) {
        guard let currentItem, !isLastPage, !isLoading else { return }
        let thresholdIndex = products.index(products.endIndex, offsetBy: -5)
        if products.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            fetchNextPage()
        }
    }

    private func fetchNextPage() {
        guard !isLoading, !isLastPage else { return }
        isLoading = true
        currentPage += 1
        productRepository.search(query: query, page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.isLoading = false
                switch result {
                case .success(let moreProducts):
                    if moreProducts.isEmpty {
                        self.isLastPage = true
                    } else {
                        self.products += moreProducts
                    }
                case .failure:
                    self.error = Strings.genericError
                }
            }
        }
    }

    func loadHistory() {
        searchHistory = searchHistoryRepository.history
    }

    func selectHistory(query: String) {
        self.query = query
        search()
    }

    func clearHistory() {
        searchHistoryRepository.clear()
        loadHistory()
    }

    func reset() {
        products = []
        isShowingHistory = true
    }
}

