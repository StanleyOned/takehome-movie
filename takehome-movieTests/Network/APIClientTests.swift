//
//  APIClientTests.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 10/1/25.
//

import XCTest
@testable import takehome_movie

/// Class to test the dataTask method of APIClient
final class APIClientTests: XCTestCase {

  // MARK: - Properties

  var apiClient: APIClient!

  // MARK: - Setup

  override func setUpWithError() throws {
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [MockURLProtocol.self]
    let session = URLSession(configuration: config)

    apiClient = APIClient(session: session)
  }

  override func tearDownWithError() throws {
    apiClient = nil
    MockURLProtocol.mockData = nil
    MockURLProtocol.mockResponse = nil
    MockURLProtocol.mockError = nil
  }

  // MARK: - Success Tests

  func testDataTaskSuccess() async throws {
    // Given
    let jsonString = """
    {
      "id": 123,
      "title": "Test Movie",
      "release_date": "2023-01-01",
      "overview": "Test overview",
      "vote_average": 8.5,
      "poster_path": "/test.jpg"
    }
    """

    guard let jsonData = jsonString.data(using: .utf8) else {
      XCTFail("Failed to convert JSON string to data")
      return
    }

    MockURLProtocol.mockData = jsonData
    MockURLProtocol.mockResponse = HTTPURLResponse(
      url: URL(string: "https://api.themoviedb.org/3/movie/123")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil
    )

    let requestBuilder = RequestBuilder(path: "/movie/123")

    // When
    let result = try await apiClient.dataTask(requestBuilder, decodingResultTo: Movie.self)

    // Then
    XCTAssertEqual(result.id, 123)
    XCTAssertEqual(result.title, "Test Movie")
  }

  // MARK: - Failure Tests

  func testDataTaskConnectionError() async {
    // Given
    MockURLProtocol.mockData = Data()
    MockURLProtocol.mockResponse = HTTPURLResponse(
      url: URL(string: "https://api.themoviedb.org/3/movie/123")!,
      statusCode: 404,
      httpVersion: nil,
      headerFields: nil
    )

    let requestBuilder = RequestBuilder(path: "/movie/123")

    // When/Then
    do {
      _ = try await apiClient.dataTask(requestBuilder, decodingResultTo: Movie.self)
      XCTFail("Expected APIClientError.connectionError to be thrown")
    } catch let error as APIClientError {
      XCTAssertEqual(error, APIClientError.connectionError)
    } catch {
      XCTFail("Expected APIClientError.connectionError, got \(error)")
    }
  }

  func testDataTaskDecodingError() async {
    // Given
    let invalidJsonString = """
    {
      "id": "invalid_id",
      "title": "Test Movie"
    }
    """

    guard let jsonData = invalidJsonString.data(using: .utf8) else {
      XCTFail("Failed to convert JSON string to data")
      return
    }

    MockURLProtocol.mockData = jsonData
    MockURLProtocol.mockResponse = HTTPURLResponse(
      url: URL(string: "https://api.themoviedb.org/3/movie/123")!,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil
    )

    let requestBuilder = RequestBuilder(path: "/movie/123")

    // When/Then
    do {
      _ = try await apiClient.dataTask(requestBuilder, decodingResultTo: Movie.self)
      XCTFail("Expected APIClientError.decodingError to be thrown")
    } catch let error as APIClientError {
      XCTAssertEqual(error, APIClientError.decodingError)
    } catch {
      XCTFail("Expected APIClientError.decodingError, got \(error)")
    }
  }
}