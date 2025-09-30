//
//  AppStateContainer.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

/// Dependency app manager for the aplication
/// Here we will initialize the app dependencies
final class AppStateContainer {
  
  // MARK: - Properties
  
  let apiClient: APIClient
  
  // MARK: - Init
  
  init() {
    self.apiClient = APIClient()
  }
}
