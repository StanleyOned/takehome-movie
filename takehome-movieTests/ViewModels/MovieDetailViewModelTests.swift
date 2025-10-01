//
//  MovieDetailViewModelTests.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 10/1/25.
//

import XCTest
@testable import takehome_movie

/// Class to tests the business logic of MovieDetailViewModel
final class MovieDetailViewModelTests: XCTestCase {

  // MARK: - Properties

  var viewModel: MovieDetailViewModel!
  var mockService: MockMovieSearchService!

  // MARK: - Setup

  override func setUpWithError() throws {
    mockService = MockMovieSearchService()
    viewModel = MovieDetailViewModel(movieId: 123, service: mockService)
  }

  override func tearDownWithError() throws {
    viewModel = nil
    mockService = nil
  }

  // MARK: - Tests

  func testLoadMovieDetailSuccess() async {
    // Given
    let expectedMovie = Movie(
      id: 123,
      title: "Test Movie Detail",
      releaseDate: "2023-01-01",
      overview: "Detailed test overview",
      voteAverage: 9.2,
      posterPath: "/detail.jpg"
    )
    mockService.mockDetailResult = .success(expectedMovie)

    // When
    await viewModel.loadMovieDetail()

    // Then
    await MainActor.run {
      XCTAssertEqual(viewModel.movie?.id, 123)
      XCTAssertEqual(viewModel.movie?.title, "Test Movie Detail")
      XCTAssertEqual(viewModel.viewState, .loaded)
      XCTAssertFalse(viewModel.showAlert)
      XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
  }

  func testLoadMovieDetailFailure() async {
    // Given
    mockService.mockDetailResult = .failure(NetworkError.invalidResponse)

    // When
    await viewModel.loadMovieDetail()

    // Then
    await MainActor.run {
      XCTAssertNil(viewModel.movie)
      XCTAssertEqual(viewModel.viewState, .error)
      XCTAssertTrue(viewModel.showAlert)
      XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
  }

  func testHideAlert() async {
    // Given
    await MainActor.run {
      viewModel.showAlert = true
      viewModel.alertMessage = "Test error message"
    }

    // When
    await MainActor.run {
      viewModel.hideAlert()
    }

    // Then
    await MainActor.run {
      XCTAssertFalse(viewModel.showAlert)
      XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
  }

  func testInitialState() async {
    // Given/When
    // ViewModel is created in setUp

    // Then
    await MainActor.run {
      XCTAssertNil(viewModel.movie)
      XCTAssertEqual(viewModel.viewState, .loading)
      XCTAssertFalse(viewModel.showAlert)
      XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
  }
}