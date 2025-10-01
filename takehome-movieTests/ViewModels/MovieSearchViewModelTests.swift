//
//  MovieSearchViewModelTests.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 10/1/25.
//

import XCTest
@testable import takehome_movie

/// Class to tests the busines logic of MovieSearchViewModel
final class MovieSearchViewModelTests: XCTestCase {

  // MARK: - Properties
  
  var viewModel: MovieSearchViewModel!
  var mockService: MockMovieSearchService!
  
  // MARK: - Setup

  override func setUpWithError() throws {
    mockService = MockMovieSearchService()
    viewModel = MovieSearchViewModel(service: mockService, coordinator: nil)
  }

  override func tearDownWithError() throws {
    viewModel = nil
    mockService = nil
  }
  
  // MARK: - Tests

  func testSearchMoviesSuccess() async {
    // Given
    let expectedMovies = [
      Movie(id: 1, title: "Test Movie", releaseDate: "2023-01-01", overview: "Test overview", voteAverage: 8.5, posterPath: "/test.jpg")
    ]
    let expectedResult = MovieResult(page: 1, results: expectedMovies, totalPages: 1, totalResults: 1)
    mockService.mockResult = .success(expectedResult)

    await MainActor.run {
      viewModel.searchQuery = "test"
    }

    // When
    await MainActor.run {
      viewModel.onSearchTextChanged()
    }
    try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second to ensure timer completes

    // Then
    await MainActor.run {
      XCTAssertEqual(viewModel.movies.count, 1)
      XCTAssertEqual(viewModel.movies.first?.title, "Test Movie")
      XCTAssertEqual(viewModel.viewState, .loaded)
      XCTAssertFalse(viewModel.showAlert)
    }
  }

  func testSearchMoviesFailure() async {
    // Given
    mockService.mockResult = .failure(NetworkError.invalidResponse)

    await MainActor.run {
      viewModel.searchQuery = "test"
    }

    // When
    await MainActor.run {
      viewModel.onSearchTextChanged()
    }
    try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second to ensure timer completes

    // Then
    await MainActor.run {
      XCTAssertTrue(viewModel.movies.isEmpty)
      XCTAssertEqual(viewModel.viewState, .error)
      XCTAssertTrue(viewModel.showAlert)
      XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
  }

  func testHideAlert() {
    // Given
    viewModel.showAlert = true
    viewModel.alertMessage = "Test error"

    // When
    viewModel.hideAlert()

    // Then
    XCTAssertFalse(viewModel.showAlert)
    XCTAssertTrue(viewModel.alertMessage.isEmpty)
  }

  func testEmptySearchQuery() async {
    // Given
    viewModel.movies = [Movie(id: 1, title: "Test", releaseDate: "2023-01-01", overview: "Test", voteAverage: 8.0, posterPath: nil)]
    viewModel.searchQuery = ""

    // When
    viewModel.onSearchTextChanged()

    // Then
    XCTAssertTrue(viewModel.movies.isEmpty)
    XCTAssertEqual(viewModel.viewState, .idle)
  }
}
