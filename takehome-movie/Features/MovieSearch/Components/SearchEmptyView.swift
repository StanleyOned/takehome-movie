//
//  SearchEmptyView.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import SwiftUI

/// Empty view for MovieSearchView
struct SearchEmptyView: View {
  
  // MARK: - Properties
  
  let text: String
  
  // MARK: - Body
  
  var body: some View {
    VStack {
      Spacer()
      ContentUnavailableView(text, systemImage: "magnifyingglass")
      Spacer()
    }
  }
}
