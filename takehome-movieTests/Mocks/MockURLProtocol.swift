//
//  MockURLProtocol.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 10/1/25.
//

import Foundation

/// Mock URLProtocol for testing network requests
class MockURLProtocol: URLProtocol {

  // MARK: - Properties

  static var mockData: Data?
  static var mockResponse: URLResponse?
  static var mockError: Error?

  // MARK: - URLProtocol Methods

  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  override func startLoading() {
    if let error = MockURLProtocol.mockError {
      client?.urlProtocol(self, didFailWithError: error)
      return
    }

    if let response = MockURLProtocol.mockResponse {
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    }

    if let data = MockURLProtocol.mockData {
      client?.urlProtocol(self, didLoad: data)
    }

    client?.urlProtocolDidFinishLoading(self)
  }

  override func stopLoading() {
    // Required override
  }
}