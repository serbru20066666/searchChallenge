//
//  SearchView.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    TextField(Strings.searchPlaceholder, text: $viewModel.query)
                        .padding(.horizontal, 12)
                        .frame(height: 40)
                        .background(Colors.field)
                        .cornerRadius(8)
                        .focused($isFocused)
                        .onSubmit { viewModel.search() }
                    Button {
                        viewModel.search()
                        isFocused = false
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Colors.primary)
                    }
                }
                .padding(.horizontal)
                .padding(.top)

                if viewModel.isShowingHistory {
                    SearchHistoryView(viewModel: viewModel)
                } else if viewModel.products.isEmpty {
                    Spacer()
                    Text(Strings.noResults)
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    productList
                }
            }
            if viewModel.isLoading {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            }
        }
        .alert(isPresented: .constant(viewModel.error != nil)) {
            Alert(title: Text(viewModel.error ?? ""), dismissButton: .default(Text("OK")) { viewModel.error = nil })
        }
        .onChange(of: viewModel.query) {
            if viewModel.query.isEmpty { viewModel.reset() }
        }
    }

    var productList: some View {
        List {
            ForEach(viewModel.products) { product in
                ProductCell(product: product)
                    .onAppear { viewModel.fetchNextPageIfNeeded(currentItem: product) }
            }
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
        }
        .listStyle(PlainListStyle())
    }
}
