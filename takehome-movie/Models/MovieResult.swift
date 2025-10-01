//
//  MovieResult.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

/// Movie result model.
struct MovieResult: Codable {
  
  /// The current page number for pagination
  let page: Int
  
  /// The results array of movies
  let results: [Movie]
  
  /// Total pages of pagination
  let totalPages: Int
  
  /// Total Results count
  let totalResults: Int
}
