//
//  Item.swift
//  
//
//  Created by Yang Xu on 2024/3/16.
//

import Foundation
import SwiftData

@Model
public final class Item {
  public var timestamp: Date
  public var createTimestamp: Date

  public init(timestamp: Date) {
    self.timestamp = timestamp
    createTimestamp = .now
  }
}
