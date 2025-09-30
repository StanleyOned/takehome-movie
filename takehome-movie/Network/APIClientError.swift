//
//  APIClientError.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import Foundation
/// Represents the set of errors that can be emitted by the "APICIent network service.
enum APIClientError: LocalizedError {
  /// The requested model type could not be deserialized from the request data.
  case decodingError
  
  /// The base url set on the environment was invalid.
  case invalidBaseURL
  
  /// Error connecting with the server
  case connectionError
  
  /// Detail description of the error found.
  var errorDescription: String? {
    switch self {
    case .decodingError:
      return Strings.NetworkError.decodingError
    case .invalidBaseURL:
      return Strings.NetworkError.badBaseURL
    case .connectionError:
      return Strings.NetworkError.connectionError
    }
  }
}
