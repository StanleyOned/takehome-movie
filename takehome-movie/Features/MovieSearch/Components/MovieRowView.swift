//
//  MovieRowView.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/29/25.
//

import SwiftUI

/// Cell/row view for Movies shown in the MovieSearchView
struct MovieRowView: View {
  
  // MARK: - Properties
  let movie: Movie
  
  // MARK: - Body
  
  var body: some View {
    VStack {
      HStack(alignment: .top, spacing: .interval12) {
        AsyncImage(url: movie.fullPosterURL) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
        } placeholder: {
          Rectangle()
            .fill(Color.gray.opacity(0.3))
            .overlay(
              Image(systemName: "photo")
                .foregroundColor(.gray)
            )
        }
        .frame(width: 70, height: 100)
        .clipped()
        .cornerRadius(.borderRadiusSmall)
        
        VStack(alignment: .leading, spacing: .interval4) {
          Text(movie.title)
            .setStyle(.heading1)
            .foregroundColor(.primary)
            .lineLimit(2)
          
          Text(movie.releaseYear)
            .setStyle(.heading2)
            .foregroundColor(.secondary)
          
          Spacer()
        }
        Spacer()
      }
      .padding(.vertical, .interval8)
      Divider()
    }
  }
}
