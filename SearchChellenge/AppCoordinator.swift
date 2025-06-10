//
//  AppCoordinator.swift
//  SearchDemoChallenge
//
//  Created by Bruno Cardenas on 10/06/25.
//
import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var root: RootRoute = .search

    enum RootRoute {
        case search
    }
}
