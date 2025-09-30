//
//  Strings.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import Foundation

/// String resource file.
/// Most likely you will have a string file to localized every string inside the application.
/// Their are some helpful third party framework that you can use like https://github.com/SwiftGen/SwiftGen
/// To handle string and assets generation.
struct Strings {
  
  // MARK: - Movie Model
  
  struct Movie {
    static let noOverview = "No overview available"
    static let tbaDescription = "TBA"
  }
  
  // MARK: - Movie search
  
  struct MovieSearch {
    static let title = "Movie Search"
    static let placeholder = "Search for a movie..."
    static let noResults = "No results found"
    static let errorMessage = "Something went wrong! please try again later"
    static let startSearching = "Start searching for movies..."
  }
  
  struct MovieDetailView {
    static let errorTitle = "Error"
    static let ok = "Ok"
    static let errorMessage = "Failed to load movie details, please try again later"
    static let viewerRating = "Viewer rating"
    static let overview = "Overview"
  }
  
  // MARK: - Network Error strings
  
  struct NetworkError {
    /// Requested model type could not be deserialized from the request data.
    static let decodingError = "Requested model type could not be deserialized from the request data."
    
    /// The base url specified by the selected environment is invalid.
    static let badBaseURL = "The base url specified by the selected environment is invalid."
    
    /// We didn't find a connection with the server, please try again later.
    static let connectionError = "We didn't find a connection with the server, please try again later."
    
  }
}
