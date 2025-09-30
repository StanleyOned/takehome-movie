//
//  Configuration.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/29/25.
//

import Foundation

enum Configuration {
  static let baseURL = "https://api.themoviedb.org/3"
  
  static var apiKey: String {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String else {
      fatalError("TMDB_API_KEY not found in Info.plist. Please check your Secrets.xcconfig file.")
    }
    
    // Check if it's still the placeholder value
    guard apiKey != "YOUR_TMDB_API_KEY_HERE" else {
      fatalError("Please add your actual TMDB API key to Config/Secrets.xcconfig")
    }
    
    return apiKey
  }
}
