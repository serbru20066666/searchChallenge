//
//  ProductCell.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import SwiftUI

struct ProductCell: View {
    let product: Product

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: product.image)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                Text(product.price)
                    .font(.subheadline)
                    .foregroundColor(Colors.primary)

                if let seller = product.sellerName {
                    Text("Sold by \(seller)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                HStack(spacing: 6) {
                    if let rating = product.averageRating {
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.caption)
                            Text(String(format: "%.1f", rating))
                                .font(.caption2)
                        }
                    }
                    if let reviews = product.numberOfReviews {
                        Text("(\(reviews))")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            Spacer()

            if product.isOutOfStock {
                Text("Out of stock")
                    .font(.caption2)
                    .padding(4)
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(4)
            }
        }
        .padding(.vertical, 4)
    }
}
