//
//  MovieResultTests.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 10/1/25.
//

import XCTest
@testable import takehome_movie

/// Class to test the deserialization logic of MovieResult model
final class MovieResultTests: XCTestCase {

  // MARK: - Tests

  func testMovieResultDeserializationSuccess() throws {
    // Given
    let jsonString = """
    {
      "page": 1,
      "results": [
        {
          "id": 123,
          "title": "Test Movie",
          "release_date": "2023-01-01",
          "overview": "Test overview",
          "vote_average": 8.5,
          "poster_path": "/test.jpg"
        }
      ],
      "total_pages": 10,
      "total_results": 100
    }
    """
    guard let jsonData = jsonString.data(using: .utf8) else {
      XCTFail("Failed to convert JSON string to data")
      return
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    // When
    let movieResult = try decoder.decode(MovieResult.self, from: jsonData)

    // Then
    XCTAssertEqual(movieResult.page, 1)
    XCTAssertEqual(movieResult.results.count, 1)
    XCTAssertEqual(movieResult.results.first?.id, 123)
    XCTAssertEqual(movieResult.results.first?.title, "Test Movie")
    XCTAssertEqual(movieResult.totalPages, 10)
    XCTAssertEqual(movieResult.totalResults, 100)
  }

  func testMovieResultDeserializationFailure() {
    // Given
    let invalidJsonString = """
    {
      "page": "invalid_number",
      "results": [],
      "total_pages": 10,
      "total_results": 100
    }
    """
    guard let jsonData = invalidJsonString.data(using: .utf8) else {
      XCTFail("Failed to convert JSON string to data")
      return
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    // When/Then
    XCTAssertThrowsError(try decoder.decode(MovieResult.self, from: jsonData)) { error in
      XCTAssertTrue(error is DecodingError)
    }
  }
}