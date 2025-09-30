//
//  AppCoordinatorView.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import SwiftUI

/// App coordinator view
struct AppCoordinatorView: View {
  
  // MARK: - Properties
  
  @StateObject private var coordinator = AppCoordinator()
  private let service: MovieSearchService
  
  // MARK: - Initializer
  
  init(service: MovieSearchService) {
    self.service = service
  }
  
  // MARK: - Body
  
  var body: some View {
    NavigationStack(path: $coordinator.path) {
      MovieSearchView(service: service)
        .navigationDestination(for: AppRoute.self) { route in
        switch route {
        case .movieDetail(let movieID):
          MovieDetailView(movieId: movieID, service: service)
        default:
          EmptyView()
        }
      }
    }
    .environmentObject(coordinator)
  }
}
