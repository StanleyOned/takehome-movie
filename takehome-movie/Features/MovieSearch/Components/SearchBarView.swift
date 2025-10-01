//
//  SearchBarView.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 10/1/25.
//

import SwiftUI

/// Custom search bar component for full control over search behavior
struct SearchBarView: View {

  // MARK: - Properties

  @Binding var text: String
  let placeholder: String
  let onTextChanged: () -> Void

  @FocusState private var isFocused: Bool

  // MARK: - Body

  var body: some View {
    HStack(spacing: .interval8) {
      Image(systemName: "magnifyingglass")
        .foregroundColor(.secondary)

      TextField(placeholder, text: $text)
        .focused($isFocused)
        .textFieldStyle(PlainTextFieldStyle())
        .onChange(of: text) { _, _ in
          onTextChanged()
        }

      if !text.isEmpty {
        Button {
          text = ""
          onTextChanged()
        } label: {
          Image(systemName: "xmark.circle.fill")
            .foregroundColor(.secondary)
        }
      }
    }
    .padding(.horizontal, .interval12)
    .padding(.vertical, .interval8)
    .background(Color(.systemGray6))
    .cornerRadius(.borderRadiusSmall)
    .padding(.horizontal, .interval16)
  }
}

// MARK: - Private Methods

private extension SearchBarView {
  
  func dismissKeyboard() {
    isFocused = false
  }
}
