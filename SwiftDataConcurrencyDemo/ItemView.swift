//
//  ItemView.swift
//  SwiftDataConcurrencyDemo
//
//  Created by Yang Xu on 2024/3/16.
//

import DataProvider
import SwiftData
import SwiftUI

struct ItemView: View {
  @Environment(\.createDataHandler) private var createDataHandler
  @Environment(\.createDataHandlerWithMainContext) private var createDataHandlerWithMainContext
  let item: Item
  var body: some View {
    VStack {
      Text("\(item.timestamp.timeIntervalSince1970)")
      HStack {
        Button("Update Timestamp") {
          updateItemTimestamp()
        }
        Button("Delete") {
          deleteItem()
        }
      }
    }
    .buttonStyle(.bordered)
  }

  @MainActor
  private func updateItemTimestamp() {
    let id = item.id
    let date = Date.now
    Task { @MainActor in
      if let dataHandler = await createDataHandlerWithMainContext() {
        try? await dataHandler.updateItem(id: id, timestamp: date)
      }
    }
  }

  @MainActor
  private func deleteItem() {
    let id = item.id
    let createDataHandler = createDataHandler
    Task.detached {
      if let dataHandler = await createDataHandler() {
        try? await dataHandler.deleteItem(id: id)
      }
    }
  }
}

#if DEBUG
  struct ItemViewPreviewContainer: View {
    @Environment(\.createDataHandler) var createDataHandler
    @Query var items: [Item]
    var body: some View {
      VStack {
        if let item = items.first {
          ItemView(item: item)
        }
      }
      .task {
        if let dataHander = await createDataHandler() {
          let _ = try? await dataHander.newItem(date: .now)
        }
      }
    }
  }
#endif

#Preview {
  let dataProvider = DataProvider()
  return ItemViewPreviewContainer()
    .environment(\.createDataHandler, dataProvider.dataHandlerCreator(preview: true))
    .environment(\.createDataHandlerWithMainContext, dataProvider.dataHandlerWithMainContextCreator(preview: true))
    .modelContainer(dataProvider.previewContainer)
}
