//
//  AppStateContainer.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import SwiftUI

/// Dependency app manager for the aplication
/// Here we will initialize the app dependencies
final class AppStateContainer: ObservableObject {
  
  // MARK: - Properties
  
  private let apiClient: APIClient
  
  // MARK: - Init
  
  init() {
    self.apiClient = APIClient()
  }
  
  func movieService() -> MovieSearchService {
    NetworkMovieSearchService(apiClient)
  }
}
