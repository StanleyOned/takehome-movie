//
//  Movie.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/29/25.
//

import Foundation

/// Model for movies
struct Movie: Codable, Identifiable, Hashable {

  // MARK: - Properties
  
  let id: Int
  let title: String

  private let overview: String
  private let voteAverage: Double
  private let releaseDate: String
  private let posterPath: String?
  
  // MARK: - Initializer
  
  init(id: Int,
       title: String,
       releaseDate: String,
       overview: String,
       voteAverage: Double,
       posterPath: String?) {
    self.id = id
    self.title = title
    self.releaseDate = releaseDate
    self.overview = overview
    self.voteAverage = voteAverage
    self.posterPath = posterPath
  }
}

// MARK: - Helpers

extension Movie {
  var fullPosterURL: URL? {
    guard let posterPath = posterPath else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
  }

  var releaseYear: String {
    String(releaseDate.prefix(4))
  }

  var formattedReleaseDate: String {
    guard !releaseDate.isEmpty else { return "TBA" }
    return releaseDate.formattedReleaseDate
  }

  var ratingText: String {
    String(format: "%.1f/10", voteAverage)
  }

  var ratingPercentage: Double {
    voteAverage / 10.0
  }

  /// From the documentation it appears that overview can be an Empty string.
  var displayOverview: String {
    guard !overview.isEmpty else { return "No overview available." }
    return overview
  }
}
