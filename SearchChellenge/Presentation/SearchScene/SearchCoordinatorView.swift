//
//  SearchCoordinatorView.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import SwiftUI
struct SearchCoordinatorView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    private let productRepository = ProductRepositoryImpl(service: ProductService())
    private let searchHistoryRepository = SearchHistoryRepositoryImpl()
    @StateObject private var viewModel = SearchViewModel(
        productRepository: ProductRepositoryImpl(service: ProductService()),
        searchHistoryRepository: SearchHistoryRepositoryImpl()
    )

    var body: some View {
        NavigationStack {
            SearchView(viewModel: viewModel)
                .navigationTitle(Strings.searchPlaceholder)
        }
    }
}
