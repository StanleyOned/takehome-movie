//
//  ContentView.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/29/25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "film")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("TMDB Movie Browser")
        .font(.title)
        .padding()
      
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
