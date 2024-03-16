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
  let item: Item
  var body: some View {
    VStack {
      Text("\(item.timestamp.timeIntervalSince1970)")
      HStack {
        Button("Update Timestamp") {
          let id = item.id
          let date = Date.now
          Task { @MainActor in
            if let dataHandler = await createDataHandler() {
              try? await dataHandler.updateItem(id: id, timestamp: date)
            }
          }
        }
        Button("Delete") {
          let id = item.id
          let createDataHandler = createDataHandler
          Task.detached {
            if let dataHandler = await createDataHandler() {
              try? await dataHandler.deleteItem(id: id)
            }
          }
        }
      }
    }
    .buttonStyle(.bordered)
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
  ItemViewPreviewContainer()
    .environment(\.createDataHandler, DataProvider.shared.dataHandlerCreator(preview: true))
    .modelContainer(DataProvider.shared.previewContainer)
}
