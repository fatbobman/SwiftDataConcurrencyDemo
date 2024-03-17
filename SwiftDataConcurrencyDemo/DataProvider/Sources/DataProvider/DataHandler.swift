//
//  DataHandler.swift
//
//
//  Created by Yang Xu on 2024/3/16.
//

import Foundation
import SwiftData

@ModelActor
public actor DataHandler {
  @MainActor
  public init(modelContainer: ModelContainer, mainActor _: Bool) {
    let modelContext = modelContainer.mainContext
    modelExecutor = DefaultSerialModelExecutor(modelContext: modelContext)
    self.modelContainer = modelContainer
  }

  @discardableResult
  public func newItem(date: Date) throws -> PersistentIdentifier {
    let item = Item(timestamp: date)
    modelContext.insert(item)
    try modelContext.save()
    return item.persistentModelID
  }

  public func updateItem(id: PersistentIdentifier, timestamp: Date) throws {
    guard let item = self[id, as: Item.self] else { return }
    item.timestamp = timestamp
    try modelContext.save()
  }

  public func deleteItem(id: PersistentIdentifier) throws {
    guard let item = self[id, as: Item.self] else { return }
    modelContext.delete(item)
    try modelContext.save()
  }
}
