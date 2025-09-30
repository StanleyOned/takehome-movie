//
//  RequestBuilder.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import Foundation

/// Object that leverages the `Builder` design pattern to configure and construct `URLRequest`.
/// Each field has an associated method that clones the `Builder` object and returns a new `Builder`
/// object with that single field modified.
struct RequestBuilder: Buildable {
  
  // MARK: - Properties
  
  /// Path to the URL request
  var path: String
  
  /// HTTPMethod of the request
  var httpMethod: RequestMethod = .get
  
  /// URLQueryItems, if any, to set the request
  var queryItems = [String: Any]()
  
  /// httpHeaderFields, if any, to set the request
  var httpHeaderFields = [String: String]()
  
  // MARK: - Initializer
  
  init(path: String) {
    self.path = path
  }
  
  // MARK: - Public Functions
  
  @discardableResult
  func httpMethod(_ httpMethod: RequestMethod) -> Self {
    mutating(\.httpMethod, to: httpMethod)
  }
  
  @discardableResult
  func httpHeaderFields(_ httpHeaderFields: [String: String]) -> Self {
    mutating(\.httpHeaderFields, to: httpHeaderFields)
  }
  
  @discardableResult
  func replacingPathPlacerholder(_ variable: String, with value: String) -> Self {
    mutating(\.path, to: path.replacingOccurrences(of: "%\(variable)%", with: value))
  }
  
  @discardableResult
  func queryItems(_ queryItems: [String: Any]) -> Self {
    mutating(\.queryItems, to: queryItems)
  }
}

// MARK: - URL Generation

extension RequestBuilder {
   
  /// Creates a urlRequest from the `RequestBuilder` instance.
  /// - Returns: A URLRequest type
  func urlRequest() throws -> URLRequest {
    
    guard let url = try getURL(with: Configuration.baseURL) else {
      throw APIClientError.invalidBaseURL
    }
    
    /// Creates a url request
    var request = URLRequest(url: url)
    
    /// Append all related properties.
    request.httpMethod = httpMethod.rawValue
        
    return request
  }
  
  private func getURL(with baseURL: String) throws -> URL? {
    // Create a URLComponents instance to compose the url.
    guard var urlComponents = URLComponents(string: baseURL) else {
      throw APIClientError.invalidBaseURL
    }
    
    
    // Adds the request path to the existing base URL path
    urlComponents.path += path
    
    // Adds Query items to the request.
    if !queryItems.isEmpty {
      urlComponents.queryItems = queryItems.compactMap {
        URLQueryItem(name: $0.key, value: String(describing: $0.value))
      }
    }
    
    // Append APIKey
    urlComponents.queryItems?.append(URLQueryItem(name: "api_key",
                                                  value: Configuration.apiKey))
    
    return urlComponents.url
  }
}
