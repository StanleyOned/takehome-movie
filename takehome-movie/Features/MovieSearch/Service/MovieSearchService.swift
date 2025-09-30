//
//  MovieSearchService.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

/// Protocol that defines the service for Movie search
protocol MovieSearchService {

  /// Fetch movies with the given string query
  /// - Parameter query: Query string
  /// - Returns: Returns a MovieResult objects
  func fetchMovies(query: String) async throws -> MovieResult

  /// Fetch detailed movie information by ID
  /// - Parameter id: Movie ID
  /// - Returns: Returns a Movie object with detailed information
  func fetchMovieDetail(id: Int) async throws -> Movie
}

