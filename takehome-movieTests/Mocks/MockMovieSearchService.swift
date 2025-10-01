//
//  MockMovieSearchService.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 10/1/25.
//

@testable import takehome_movie

/// Mock implementation of MovieSearchService for testing
class MockMovieSearchService: MovieSearchService {

  // MARK: - Properties

  var mockResult: Result<MovieResult, Error>?
  var mockDetailResult: Result<Movie, Error>?

  // MARK: - MovieSearchService Methods

  func fetchMovies(query: String) async throws -> MovieResult {
    guard let result = mockResult else {
      throw NetworkError.invalidResponse
    }

    switch result {
    case .success(let movieResult):
      return movieResult
    case .failure(let error):
      throw error
    }
  }

  func fetchMovieDetail(id: Int) async throws -> Movie {
    guard let result = mockDetailResult else {
      throw NetworkError.invalidResponse
    }

    switch result {
    case .success(let movie):
      return movie
    case .failure(let error):
      throw error
    }
  }
}

// MARK: - NetworkError

enum NetworkError: Error {
  case invalidResponse
  case noData
}
