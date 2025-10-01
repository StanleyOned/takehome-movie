//
//  BorderRadius.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 10/1/25.
//

import Foundation

/// Border radius for our app
enum BorderRadius: CGFloat {
  case small = 8
  case medium = 16
  case large = 24
}

extension CGFloat {
    
  /// small float radius 8px
  static let borderRadiusSmall: CGFloat = BorderRadius.small.rawValue
  
  /// medium float radius 16px
  static let borderRadiusMedium: CGFloat = BorderRadius.medium.rawValue
  
  /// large float radius 24px
  static let borderRadiusLarge: CGFloat = BorderRadius.large.self.rawValue
}
