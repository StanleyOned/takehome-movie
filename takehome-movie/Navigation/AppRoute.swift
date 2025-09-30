//
//  AppRoute.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

// Define a `Hashable` enum for your navigation destinations
enum AppRoute: Hashable {
  /// Home search view
  case movieSearch
  /// Movie detail
  case movieDetail(movieID: Int)
}
