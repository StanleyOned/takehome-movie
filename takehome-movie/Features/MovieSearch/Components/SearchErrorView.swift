//
//  SearchErrorView.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import SwiftUI

struct SearchErrorView: View {
  
  // MARK: - Properties
  
  private let title: String
  private let imageSize: CGFloat = 80
  
  init(title: String) {
    self.title = title
  }
  
  var body: some View {
    VStack(spacing: .interval12) {
      Image(systemName: "exclamationmark.triangle.fill")
        .resizable()
        .frame(width: imageSize, height: imageSize)
        .foregroundStyle(.red)
      Text(title)
        .setStyle(.heading1)
        .multilineTextAlignment(.center)
    }
    .padding(.horizontal, .interval12)
  }
}

#Preview {
  SearchErrorView(title: "Error screen")
}
