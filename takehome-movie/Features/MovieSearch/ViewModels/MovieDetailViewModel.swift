//
//  MovieDetailViewModel.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import SwiftUI

/// View model which defines the business logic for MovieDetail feature.
final class MovieDetailViewModel: ObservableObject {

  // MARK: - Properties

  @Published var movie: Movie?
  @Published var viewState: ViewState = .loading
  @Published var showAlert = false
  @Published var alertMessage: String = ""
  
  var errorTitle = Strings.MovieDetailView.errorTitle
  var okText = Strings.MovieDetailView.ok
  var errorMessage = Strings.MovieDetailView.errorMessage
  var viewerRatingText = Strings.MovieDetailView.viewerRating
  var overviewText = Strings.MovieDetailView.overview

  private let service: MovieSearchService
  private let movieId: Int

  enum ViewState {
    case loading
    case loaded
    case error
  }

  // MARK: - Init

  init(movieId: Int, service: MovieSearchService) {
    self.movieId = movieId
    self.service = service
  }

  func hideAlert() {
    showAlert = false
    alertMessage = ""
  }

  @MainActor
  func loadMovieDetail() async {
    viewState = .loading

    do {
      let movieDetail = try await service.fetchMovieDetail(id: movieId)
      self.movie = movieDetail
      viewState = .loaded
    } catch {
      alertMessage = errorMessage
      showAlert = true
      viewState = .error
    }
  }
}
