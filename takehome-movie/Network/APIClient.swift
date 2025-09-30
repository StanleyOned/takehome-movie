//
//  APIClient.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import Foundation

/// Client service for this application
final class APIClient {
  
  /// URLSession
  /// We add a default configuration in the constructor
  private let session: URLSession
  
  init() {
    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.waitsForConnectivity = true
    sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
    sessionConfiguration.timeoutIntervalForRequest = 30
    self.session = URLSession(configuration: sessionConfiguration)
  }
  
  /// Perform a dataTask request using the below parameters
  /// - Parameters:
  ///   - builder: The URLRequest Builder from the RequestBuilder object
  ///   - modelType: The model type that you want to serialize
  /// - Returns: Returns the given model type
  func dataTask<T: Decodable>(_ builder: RequestBuilder,
                              decodingResultTo modelType: T.Type) async throws -> T {
    
    let (data, response) = try await session.data(for: builder.urlRequest())
    
    if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
      throw APIClientError.connectionError
    }
    do {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      return try decoder.decode(modelType, from: data)
    } catch {
      throw APIClientError.decodingError
    }
  }
}
