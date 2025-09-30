//
//  RequestBuildable.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import Foundation

/// Protocol that allows for convenient of a `RequestBuilder` from an enum with a `String` associated type.
protocol RequestBuildable: RawRepresentable<String> {
  var builder: RequestBuilder { get }
}

extension RequestBuildable {
  
  var builder: RequestBuilder {
    .init(path: rawValue)
  }
}
