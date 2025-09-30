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
  let releaseDate: String
  
  private let posterPath: String?
  
  enum CodingKeys: String, CodingKey {
    case id, title
    case posterPath = "poster_path"
    case releaseDate = "release_date"
  }
}

extension Movie {
  var fullPosterURL: URL? {
    guard let posterPath = posterPath else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
  }
  
  var releaseYear: String {
    String(releaseDate.prefix(4))
  }
}
