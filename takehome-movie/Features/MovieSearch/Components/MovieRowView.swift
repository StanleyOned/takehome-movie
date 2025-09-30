//
//  MovieRowView.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/29/25.
//

import SwiftUI

struct MovieRowView: View {
  let movie: Movie
  
  var body: some View {
    HStack(spacing: .interval12) {
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
      .frame(width: 60, height: 90)
      .clipped()
      .cornerRadius(8)
      
      VStack(alignment: .leading, spacing: .interval4) {
        Text(movie.title)
          .font(.headline)
          .foregroundColor(.primary)
          .lineLimit(2)
        
        Text(movie.releaseYear)
          .font(.subheadline)
          .foregroundColor(.secondary)
        
        Spacer()
      }
      Spacer()
    }
    .padding(.vertical, .interval8)
  }
}
