//
//  AppCoordinator.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import SwiftUI

/// App coordinator object to handle navigation path
final class AppCoordinator: ObservableObject {
  
  // MARK: - Properties
  @Published var path = NavigationPath()
  
  // MARK: - Public Functions
  
  func push(page: AppRoute) {
    path.append(page)
  }
  
  func pop() {
    path.removeLast()
  }
  
  func popToRoot() {
    path.removeLast(path.count)
  }
}
