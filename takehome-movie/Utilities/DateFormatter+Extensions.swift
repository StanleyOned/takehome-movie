//
//  DateFormatter+Extensions.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import Foundation

/// Date helpers
extension DateFormatter {
  
  static let tmdbDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  static let displayDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM d, yyyy"
    return formatter
  }()
}

extension String {
  
  var formattedReleaseDate: String {
    guard let date = DateFormatter.tmdbDateFormatter.date(from: self) else {
      return self
    }
    return DateFormatter.displayDateFormatter.string(from: date)
  }
}
