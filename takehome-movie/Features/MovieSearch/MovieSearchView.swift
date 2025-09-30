//
//  MovieSearchView.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/29/25.
//

import SwiftUI

/// View for Movie search feature
struct MovieSearchView: View {
  
  // MARK: - Public Properties
  
  @StateObject private var viewModel: MovieSearchViewModel = .init()
  
  // MARK: - Body
  
  // TODO: Move strings to view model and their own String file.
  var body: some View {
    NavigationStack {
      VStack {
        switch viewModel.viewState {
        case .loading:
          ProgressView()
        case .loaded:
          listView
          if viewModel.movies.isEmpty {
            SearchEmptyView(text: "No Results")
          } else {
            listView
          }
        case .idle:
          Text("Start searching...")
        }
      }
      .navigationTitle("Movie Search")
    }
    .searchable(text: $viewModel.searchQuery, prompt: "Search")
  }
}

// MARK: - Private Functions & Properties

private extension MovieSearchView {
  
  var listView: some View {
    List(viewModel.movies) { movie in
      MovieRowView(movie: movie)
        .listRowSeparator(.hidden)
    }
    .listStyle(PlainListStyle())
  }
}

#Preview {
  MovieSearchView()
}
