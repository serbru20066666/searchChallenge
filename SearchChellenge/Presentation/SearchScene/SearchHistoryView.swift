//
//  SearchHistoryView.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import SwiftUI

struct SearchHistoryView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(Strings.historyTitle)
                    .font(.headline)
                    .padding(.leading)
                Spacer()
                if !viewModel.searchHistory.isEmpty {
                    Button(Strings.clear) {
                        viewModel.clearHistory()
                    }
                    .foregroundColor(.red)
                    .padding(.trailing)
                }
            }
            if viewModel.searchHistory.isEmpty {
                Text(Strings.emptyHistory)
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                List {
                    ForEach(viewModel.searchHistory, id: \.self) { query in
                        Button(action: {
                            viewModel.selectHistory(query: query)
                        }) {
                            Text(query)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            Spacer()
        }
    }
}

