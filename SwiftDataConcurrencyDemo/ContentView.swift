//
//  ContentView.swift
//  SwiftDataConcurrencyDemo
//
//  Created by Yang Xu on 2024/3/16.
//

import DataProvider
import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Environment(\.createDataHandler) private var createDataHandler
  @Query(sort: \Item.createTimestamp, animation: .smooth) private var items: [Item]

  var body: some View {
    NavigationSplitView {
      List {
        ForEach(items) { item in
          VStack {
            Text("\(item.timestamp.timeIntervalSince1970)")
            ItemView(item: item)
          }
        }
      }
      .toolbar {
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
    } detail: {
      Text("Select an item")
    }
  }

  @MainActor
  private func addItem() {
    let createDataHandler = createDataHandler
    Task.detached {
      if let dataHandler = await createDataHandler() {
        try await dataHandler.newItem(date: .now)
      }
    }
  }
}

#Preview {
  ContentView()
    .environment(\.createDataHandler, DataProvider.shared.dataHandlerCreator(preview: true))
    .modelContainer(DataProvider.shared.previewContainer)
}
