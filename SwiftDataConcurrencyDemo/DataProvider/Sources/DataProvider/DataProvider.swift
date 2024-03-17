//
//  DataProvider.swift
//
//  Created by Yang Xu on 2024/3/16.
//

import Foundation
import SwiftData
import SwiftUI

public final class DataProvider: Sendable {
  public static let shared = DataProvider()

  public let sharedModelContainer: ModelContainer = {
    let schema = Schema(CurrentScheme.models)
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()

  public let previewContainer: ModelContainer = {
    let schema = Schema(CurrentScheme.models)
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()

  public init() {}

  public func dataHandlerCreator(preview: Bool = false) -> @Sendable () async -> DataHandler {
    let container = preview ? previewContainer : sharedModelContainer
    return { DataHandler(modelContainer: container) }
  }

  public func dataHandlerWithMainContextCreator(preview: Bool = false) -> @Sendable @MainActor () async -> DataHandler {
    let container = preview ? previewContainer : sharedModelContainer
    return { DataHandler(modelContainer: container, mainActor: true) }
  }
}

public struct DataHandlerKey: EnvironmentKey {
  public static let defaultValue: @Sendable () async -> DataHandler? = { nil }
}

extension EnvironmentValues {
  public var createDataHandler: @Sendable () async -> DataHandler? {
    get { self[DataHandlerKey.self] }
    set { self[DataHandlerKey.self] = newValue }
  }
}

public struct MainActorDataHandlerKey: EnvironmentKey {
  public static let defaultValue: @Sendable @MainActor () async -> DataHandler? = { nil }
}

extension EnvironmentValues {
  public var createDataHandlerWithMainContext: @Sendable @MainActor () async -> DataHandler? {
    get { self[MainActorDataHandlerKey.self] }
    set { self[MainActorDataHandlerKey.self] = newValue }
  }
}
