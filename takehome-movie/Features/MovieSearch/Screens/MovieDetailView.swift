//
//  MovieDetailView.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import SwiftUI

/// Detail screen for movie detail
struct MovieDetailView: View {
  @StateObject private var viewModel: MovieDetailViewModel
  
  init(movieId: Int, service: MovieSearchService) {
    _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId, service: service))
  }
  
  var body: some View {
    VStack {
      switch viewModel.viewState {
      case .loading:
        ProgressView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      case .loaded:
        if let movie = viewModel.movie {
          movieDetailContent(movie: movie)
        }
      case .error:
        Text(viewModel.errorMessage)
          .setStyle(.heading2)
      }
    }
    .task {
      await viewModel.loadMovieDetail()
    }
    .alert(viewModel.errorTitle, isPresented: $viewModel.showAlert) {
      Button(viewModel.okText) {
        viewModel.hideAlert()
      }
    } message: {
      Text(viewModel.alertMessage)
    }
  }
}

// MARK: - Private Views

private extension MovieDetailView {
  
  @ViewBuilder
  func movieDetailContent(movie: Movie) -> some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .interval16) {
        headerSection(movie: movie)
        Divider()
        overviewSection(movie: movie)
        Spacer()
      }
      .padding(.interval16)
    }
  }
  
  func headerSection(movie: Movie) -> some View {
    HStack(alignment: .top, spacing: .interval16) {
      AsyncImage(url: movie.fullPosterURL) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
      } placeholder: {
        Rectangle()
          .fill(Color.gray.opacity(0.3))
          .overlay(
            Image(systemName: "photo")
              .foregroundColor(.gray)
          )
      }
      .frame(width: 120, height: 180)
      .clipped()
      .cornerRadius(.interval8)
      
      VStack(alignment: .leading, spacing: .interval8) {
        Text(movie.title)
          .setStyle(.heading1)
          .lineLimit(nil)
        
        Text(movie.formattedReleaseDate)
          .setStyle(.heading2)
          .foregroundColor(.secondary)
          .padding(.bottom, .interval24)
        
        ratingSection(movie: movie)
      }
      
      Spacer()
    }
  }
  
  func ratingSection(movie: Movie) -> some View {
    VStack(alignment: .leading, spacing: .interval8) {
      Text(viewModel.viewerRatingText)
        .setStyle(.eyebrown)
        .foregroundColor(.secondary)
      
      HStack(spacing: .interval8) {
        Text(movie.ratingText)
          .setStyle(.body1)
        
        ProgressView(value: movie.ratingPercentage)
          .progressViewStyle(LinearProgressViewStyle(tint: .blue))
          .frame(height: .interval8)
      }
    }
  }
  
  func overviewSection(movie: Movie) -> some View {
    VStack(alignment: .leading, spacing: .interval12) {
      Text(viewModel.overviewText.uppercased())
        .setStyle(.heading1)
        .foregroundColor(.secondary)
      
      Text(movie.displayOverview)
        .setStyle(.body1)
        .lineLimit(nil)
    }
  }
}

#Preview {
  NavigationView {
    MovieDetailView(movieId: 299536, service: NetworkMovieSearchService(APIClient()))
  }
}
