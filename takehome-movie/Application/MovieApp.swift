//
//  MovieApp.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/29/25.
//

import SwiftUI

/// Main app view
@main
struct MovieApp: App {
  
  // MARK: - Properties
  
  private let appStateContainer = AppStateContainer()
  
  // MARK: - Body
  
  var body: some Scene {
    WindowGroup {
      MovieSearchView(service: NetworkMovieSearchService(appStateContainer.apiClient))
    }
  }
}
