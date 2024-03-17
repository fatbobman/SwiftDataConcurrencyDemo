//
//  SwiftDataConcurrencyDemoApp.swift
//  SwiftDataConcurrencyDemo
//
//  Created by Yang Xu on 2024/3/16.
//

import DataProvider
import SwiftData
import SwiftUI

@main
struct SwiftDataConcurrencyDemoApp: App {
  let dataProvider = DataProvider.shared

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.createDataHandler, dataProvider.dataHandlerCreator())
        .environment(\.createDataHandlerWithMainContext, dataProvider.dataHandlerWithMainContextCreator())
    }
    .modelContainer(dataProvider.sharedModelContainer)
  }
}
