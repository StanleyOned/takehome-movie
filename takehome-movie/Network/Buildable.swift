//
//  Buildable.swift
//  takehome-movie
//
//  Created by Stanle De la Cruz on 9/30/25.
//

import Foundation

/// Represends an object that conforms to the `Builder` pattern, allowing it to be modified
/// via chain-able, atomic mutations
///
/// You can conform a struct to this protocol and leverage `func mutating` to create functions
/// that modify a struct in some way, returning a new instance of the struct with that field modified.
///
/// See `RequestBuilder` for an implementation example.
protocol Buildable {
  
  @discardableResult
  func mutating<T>(_ path: WritableKeyPath<Self, T>, to value: T) -> Self
}

extension Buildable {
  
  @discardableResult
  func mutating<T>(_ path: WritableKeyPath<Self, T>, to value: T) -> Self {
    var clone = self
    clone[keyPath: path] = value
    return clone
  }
}
