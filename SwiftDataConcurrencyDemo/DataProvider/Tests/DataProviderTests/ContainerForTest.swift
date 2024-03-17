//
//  File.swift
//
//
//  Created by Yang Xu on 2024/3/16.
//

@testable import DataProvider
import Foundation
import SwiftData

enum ContainerForTest {
  static func temp(_ name: String, delete: Bool = true) throws -> ModelContainer {
    let url = URL.temporaryDirectory.appending(component: name)
    if delete, FileManager.default.fileExists(atPath: url.path) {
      try FileManager.default.removeItem(at: url)
    }
    let schema = Schema(CurrentScheme.models)
    let configuration = ModelConfiguration(url: url)
    let container = try! ModelContainer(for: schema, configurations: configuration)
    return container
  }
}
