//
//  Spacing.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import Foundation

/// enum that defines the spacing intervals for the app
enum Spacing: CGFloat {
  case interval_0 = 0
  case interval_4 = 4
  case interval_8 = 8
  case interval_12 = 12
  case interval_16 = 16
  case interval_24 = 24
}

extension CGFloat {
  static let interval0: CGFloat = Spacing.interval_0.rawValue
  static let interval4: CGFloat = Spacing.interval_4.rawValue
  static let interval8: CGFloat = Spacing.interval_8.rawValue
  static let interval12: CGFloat = Spacing.interval_12.rawValue
  static let interval16: CGFloat = Spacing.interval_16.rawValue
  static let interval24: CGFloat = Spacing.interval_24.rawValue
}
