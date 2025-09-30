//
//  TextStyle.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import SwiftUI

/// Simple text style representation for this application
struct TextStyle {
  /// Using Baskerville for an elegant, cinematic feel
  var fontFamily: String = "Baskerville"
  /// Size of the font
  let fontSize: CGFloat
  /// Weight of the font
  let fontWeight: Font.Weight
  /// Line height of the font
  let lineHeight: CGFloat
}

// MARK: - ViewModifier:

struct TextStyleModifier: ViewModifier {
  let textStyle: TextStyle

  func body(content: Content) -> some View {
    content
      .font(Font.custom(textStyle.fontFamily, size: textStyle.fontSize)
        .weight(textStyle.fontWeight))
  }
}

// MARK: - Create our styles:

extension TextStyle {
  
  static let heading1 = TextStyle(fontSize: 18,
                                  fontWeight: .bold,
                                  lineHeight: 10)
  static let heading2 = TextStyle(fontSize: 16,
                                  fontWeight: .semibold,
                                  lineHeight: 10)
  static let body1 = TextStyle(fontSize: 16,
                               fontWeight: .regular,
                               lineHeight: 10)
  
  static let body2 = TextStyle(fontSize: 14,
                               fontWeight: .regular,
                               lineHeight: 10)
  static let eyebrown = TextStyle(fontSize: 16,
                                  fontWeight: .semibold,
                                  lineHeight: 10)
}

// MARK: - Create View extension:

extension View {
  func setStyle(_ textStyle: TextStyle) -> some View {
    modifier(TextStyleModifier(textStyle: textStyle))
  }
}
