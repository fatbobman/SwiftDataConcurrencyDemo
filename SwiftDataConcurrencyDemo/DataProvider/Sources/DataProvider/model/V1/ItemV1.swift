//
//  Item.swift
//
//
//  Created by Yang Xu on 2024/3/16.
//

import Foundation
import SwiftData

public typealias Item = SchemaV1.Item

extension SchemaV1 {
  @Model
  public final class Item {
    public var timestamp: Date
    public var createTimestamp: Date

    public init(timestamp: Date) {
      self.timestamp = timestamp
      createTimestamp = .now
    }
  }
}
