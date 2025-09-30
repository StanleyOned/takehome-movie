//
//  RequestMethod.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import Foundation

/// HTTP request method
public enum RequestMethod: String {
  
  /// HTTP GET
  case get = "GET"

  /// HTTP POST
  case post = "POST"
  
  /// HTTP PUT
  case put = "PUT"
  
  /// HTTP PATCH
  case patch = "PATCH"

  /// HTTP DELETE
  case delete = "DELETE"
}
