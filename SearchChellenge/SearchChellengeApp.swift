//
//  SearchChellengeApp.swift
//  SearchChellenge
//
//  Created by Bruno Cardenas on 10/06/25.
//

import SwiftUI

@main
struct SearchChellengeApp: App {
    @StateObject var coordinator = AppCoordinator()
    var body: some Scene {
        WindowGroup {
            SearchCoordinatorView()
                .environmentObject(coordinator)
        }
    }
}
