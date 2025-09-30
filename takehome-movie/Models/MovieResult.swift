//
//  MovieResult.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

struct MovieResult: Codable {
  let page: Int
  let results: [Movie]
  let totalPages: Int
  let totalResults: Int
}
