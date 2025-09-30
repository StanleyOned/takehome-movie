//
//  NetworkMovieSearchService.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import Foundation

/// Movie service layer, we want to separate the service
/// by features because a given feature can grow significantly
/// and we want to have separation of concern as much as possible
/// this prepares the app for scalability.
final class NetworkMovieSearchService: MovieSearchService {
  
  // MARK: - Properties
  
  private let api: APIClient
  
  // MARK: - Initializer
  
  init(_ api: APIClient) {
    self.api = api
  }
  
  // MARK: - Public Functions
  
  func fetchMovies(query: String) async throws -> MovieResult {
    let builder = MoviesEndpoint.getMovies.builder
      .queryItems(["query": query, "include_adult": "false", "page": 1, "language": "en-US"])
    let movieResult = try await api.dataTask(builder, decodingResultTo: MovieResult.self)
    return movieResult
  }

  func fetchMovieDetail(id: Int) async throws -> Movie {
    let builder = MoviesEndpoint.getMovieDetail.builder
      .replacingPathPlacerholder("id", with: String(id))
      .queryItems(["language": "en-US"])
    return try await api.dataTask(builder, decodingResultTo: Movie.self)
  }

}

// MARK: - Private Functions & Properties

private extension NetworkMovieSearchService {
  enum MoviesEndpoint: String, RequestBuildable {
    case getMovies = "/search/movie"
    case getMovieDetail = "/movie/%id%"
  }
}
