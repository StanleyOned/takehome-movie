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
  @Published var searchQuery: String = ""
  @Published var viewState: ViewState = .idle
  @Published var showAlert = false
  @Published var alertMessage: String = ""
  
  var searchMessage = Strings.MovieSearch.startSearching
  var title = Strings.MovieSearch.title
  var noResultsMessage = Strings.MovieSearch.noResults
  var placeholderText = Strings.MovieSearch.placeholder

  private var timer: Timer?
  private let service: MovieSearchService
  private let coordinator: AppCoordinator?
  
  enum ViewState {
    case idle
    case loading
    case loaded
    case error
  }
  
  // MARK: - Init
  
  init (service: MovieSearchService, coordinator: AppCoordinator?) {
    self.service = service
    self.coordinator = coordinator
  }
  
  func hideAlert() {
    showAlert = false
    alertMessage = ""
  }
  
  func navigateToDetail(for movie: Movie) {
    coordinator?.push(page: .movieDetail(movieID: movie.id))
  }
  
  func onSearchTextChanged() {
    timer?.invalidate()
    if searchQuery.isEmpty {
      movies = []
      viewState = .idle
      return
    }
    viewState = .loading

    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
      guard let self, !searchQuery.isEmpty else {
        self?.movies = []
        self?.viewState = .idle
        return
      }
      viewState = .loading
      Task {
        await self.searchMovies()
      }
    })
  }
}

// MARK: - Private Functions

private extension MovieSearchViewModel {
  
  @MainActor
  func searchMovies() async {
    do {
      let movieResult = try await service.fetchMovies(query: searchQuery)
      self.movies = movieResult.results
      viewState = .loaded
    } catch {
      alertMessage = Strings.MovieSearch.errorMessage
      showAlert = true
      viewState = .error
    }
  }
}
