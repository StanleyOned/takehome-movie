//
//  MovieSearchViewModel.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import SwiftUI

/// View model which defines the business logic for MovieSearch feature.
final class MovieSearchViewModel: ObservableObject {
  
  // MARK: - Properties
  
  @Published var movies: [Movie] = []
  @Published var searchQuery: String = "" {
    didSet {
      onSearchTextChanged()
    }
  }
  var viewState: ViewState = .idle
  
  private var timer: Timer?
  
  enum ViewState {
    case idle
    case loading
    case loaded
  }
  
  // MARK: - Init
  
  init () {
    
  }
}

// MARK: - Private Functions

private extension MovieSearchViewModel {
  
  func searchMovies() {
    // TODO: Add API Call
    
  }
  
  func onSearchTextChanged() {
    timer?.invalidate()
    if !searchQuery.isEmpty {
      viewState = .loading
    }
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
      guard let self, !searchQuery.isEmpty else {
        self?.movies = []
        self?.viewState = .idle
        return
      }
      viewState = .loading
      self.searchMovies()
    })
  }
}
