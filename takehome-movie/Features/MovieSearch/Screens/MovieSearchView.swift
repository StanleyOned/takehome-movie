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
  
  @EnvironmentObject var coordinator: AppCoordinator
  @StateObject private var viewModel: MovieSearchViewModel
  
  init(service: MovieSearchService) {
    _viewModel = StateObject(wrappedValue: MovieSearchViewModel(service: service))
  }
  
  // MARK: - Body
  
  var body: some View {
    VStack {
      switch viewModel.viewState {
      case .loading:
        ProgressView()
      case .loaded:
        if viewModel.movies.isEmpty {
          SearchEmptyView(text: viewModel.noResultsMessage)
        } else {
          listView
        }
      case .idle:
        Text(viewModel.searchMessage)
      case .error:
        SearchErrorView(title: viewModel.alertMessage)
      }
    }
    .navigationTitle(viewModel.title)
    .searchable(text: $viewModel.searchQuery, prompt: viewModel.placeholderText)
  }
}

// MARK: - Private Functions & Properties

private extension MovieSearchView {
  
  var listView: some View {
    List(viewModel.movies) { movie in
      Button {
        coordinator.push(page: .movieDetail(movieID: movie.id))
      } label: {
        MovieRowView(movie: movie)
          .listRowSeparator(.hidden)
          .listRowInsets(EdgeInsets())
          .padding(.horizontal, .interval16)
      }

    }
    .listStyle(PlainListStyle())
  }
}

#Preview {
  MovieSearchView(service: NetworkMovieSearchService(APIClient()))
}
