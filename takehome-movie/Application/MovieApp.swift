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
  @StateObject private var appStateContainer = AppStateContainer()
  
  // MARK: - Body
  
  var body: some Scene {
    WindowGroup {
      AppCoordinatorView(service: appStateContainer.movieService())
    }
  }
}
