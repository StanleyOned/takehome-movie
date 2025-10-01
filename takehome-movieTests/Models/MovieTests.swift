//
//  MovieTests.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 10/1/25.
//

import XCTest
@testable import takehome_movie

/// Class to test the deserialization logic of Movie model
final class MovieTests: XCTestCase {

  // MARK: - Tests

  func testMovieDeserializationSuccess() throws {
    // Given
    let jsonString = """
    {
      "id": 123,
      "title": "Test Movie",
      "release_date": "2023-01-01",
      "overview": "A great test movie with an amazing plot",
      "vote_average": 8.5,
      "poster_path": "/test_poster.jpg"
    }
    """
    guard let jsonData = jsonString.data(using: .utf8) else {
      XCTFail("Failed to convert JSON string to data")
      return
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    // When
    let movie = try decoder.decode(Movie.self, from: jsonData)

    // Then
    XCTAssertEqual(movie.id, 123)
    XCTAssertEqual(movie.title, "Test Movie")
    XCTAssertEqual(movie.releaseYear, "2023")
    XCTAssertEqual(movie.ratingText, "8.5/10")
    XCTAssertEqual(movie.ratingPercentage, 0.85, accuracy: 0.01)
  }

  func testMovieDeserializationFailure() {
    // Given
    let invalidJsonString = """
    {
      "id": "invalid_id",
      "title": "Test Movie",
      "release_date": "2023-01-01",
      "overview": "Test overview",
      "vote_average": 8.5,
      "poster_path": "/test.jpg"
    }
    """
    guard let jsonData = invalidJsonString.data(using: .utf8) else {
      XCTFail("Failed to convert JSON string to data")
      return
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    // When/Then
    XCTAssertThrowsError(try decoder.decode(Movie.self, from: jsonData)) { error in
      XCTAssertTrue(error is DecodingError)
    }
  }
}