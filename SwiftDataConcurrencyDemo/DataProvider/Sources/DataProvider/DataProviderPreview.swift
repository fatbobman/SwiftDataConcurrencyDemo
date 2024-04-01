//
//  DataProviderPreview.swift
//
//
//  Created by tdt on 2024/4/1.
//

import Foundation
import SwiftData
import SwiftUI

public struct DataProviderPreview<Model: PersistentModel, Content: View>: View {

  var content: (DataProvider, Model) -> Content
  let provider: DataProvider

  public init(provider: DataProvider = .shared, @ViewBuilder content: @escaping (DataProvider, Model) -> Content) {
    self.provider = provider
    self.content = content
  }

  public var body: some View {
    DataProviderContainerPreview(provider: provider) { provider in
      PreviewContentView(provider: provider, content: content)
    }
  }

  struct PreviewContentView: View {
    let provider: DataProvider
    var content: (DataProvider, Model) -> Content
    @Query private var models: [Model]
    var body: some View {
      if let model = models.first {
        content(provider, model)
      }
    }
  }
}

public struct DataProviderContainerPreview<Content: View>: View {

  var content: (DataProvider) -> Content
  let container: ModelContainer
  let provider: DataProvider

  public init(provider: DataProvider = .shared, @ViewBuilder content: @escaping (DataProvider) -> Content) {
    self.provider = provider
    self.content = content
    self.container =  provider.previewContainer
  }

  public var body: some View {
    content(provider)
      .modelContainer(container)
      .environment(\.createDataHandler, provider.dataHandlerCreator(preview: true))
      .environment(\.createDataHandlerWithMainContext, provider.dataHandlerWithMainContextCreator(preview: true))
  }

}
