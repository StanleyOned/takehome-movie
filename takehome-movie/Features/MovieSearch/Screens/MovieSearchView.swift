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

  @StateObject private var viewModel: MovieSearchViewModel
  
  init(service: MovieSearchService, coordinator: AppCoordinator) {
    _viewModel = StateObject(wrappedValue: MovieSearchViewModel(service: service, coordinator: coordinator))
  }
  
  // MARK: - Body
  
  var body: some View {
    VStack(spacing: .interval0) {
      searchBarView
      switch viewModel.viewState {
      case .loading:
        loadingView
      case .loaded:
        if viewModel.movies.isEmpty {
          SearchEmptyView(text: viewModel.noResultsMessage)
        } else {
          listView
        }
      case .idle:
        idleView
      case .error:
        errorView
      }
    }
    .navigationTitle(viewModel.title)
  }
}

// MARK: - Private Functions & Properties

private extension MovieSearchView {
  
  @ViewBuilder
  var loadingView: some View {
    Spacer()
    ProgressView()
    Spacer()
  }
  
  var searchBarView: some View {
    SearchBarView(text: $viewModel.searchQuery,
                  placeholder: viewModel.placeholderText,
                  onTextChanged: viewModel.onSearchTextChanged)
  }
  
  @ViewBuilder
  var errorView: some View {
    Spacer()
    SearchErrorView(title: viewModel.alertMessage)
    Spacer()
  }
  
  var listView: some View {
    List(viewModel.movies) { movie in
      Button {
        viewModel.navigateToDetail(for: movie)
      } label: {
        MovieRowView(movie: movie)
          .listRowSeparator(.hidden)
          .listRowInsets(EdgeInsets())
          .padding(.horizontal, .interval16)
      }
    }
    .listStyle(PlainListStyle())
  }
  
  @ViewBuilder
  var idleView: some View {
    Spacer()
    Text(viewModel.searchMessage)
    Spacer()
  }
}

#Preview {
  MovieSearchView(service: NetworkMovieSearchService(APIClient()), coordinator: AppCoordinator())
}
