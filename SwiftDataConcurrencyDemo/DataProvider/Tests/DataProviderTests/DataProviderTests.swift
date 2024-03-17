@testable import DataProvider
import SwiftData
import XCTest

final class DataProviderTests: XCTestCase {
  @MainActor
  func testNewItem() async throws {
    // Arrange
    let container = try ContainerForTest.temp(#function)
    let hander = DataHandler(modelContainer: container)

    // ACT
    let date = Date(timeIntervalSince1970: 0)
    try await hander.newItem(date: date)

    // Assert
    let fetchDescriptor = FetchDescriptor<Item>()
    let items = try container.mainContext.fetch(fetchDescriptor)

    XCTAssertNotNil(items.first, "The item should be created and fetched successfully.")
    XCTAssertEqual(items.count, 1, "There should be exactly one item in the store.")

    if let firstItem = items.first {
      XCTAssertEqual(firstItem.timestamp, date, "The item's timestamp should match the initially provided date.")
    } else {
      XCTFail("Expected to find an item but none was found.")
    }
  }

  @MainActor
  func testDeleteItem() async throws {
    // Arrange
    let container = try ContainerForTest.temp(#function)
    let hander = DataHandler(modelContainer: container)
    let date = Date(timeIntervalSince1970: 0)
    let itemID = try await hander.newItem(date: date)

    // Act
    try await hander.deleteItem(id: itemID)

    // Assert
    let fetchDescriptor = FetchDescriptor<Item>()
    let itemCount = try container.mainContext.fetchCount(fetchDescriptor)

    XCTAssertEqual(itemCount, 0)
  }

  @MainActor
  func testUpdateItem() async throws {
    // Arrange
    let container = try ContainerForTest.temp(#function)
    let hander = DataHandler(modelContainer: container)
    let date = Date(timeIntervalSince1970: 0)
    let itemID = try await hander.newItem(date: date)

    // Act
    let newDate = Date(timeIntervalSince1970: 1)
    try await hander.updateItem(id: itemID, timestamp: newDate)

    // Assert
    let fetchDescriptor = FetchDescriptor<Item>()
    let items = try container.mainContext.fetch(fetchDescriptor)

    XCTAssertNotNil(items.first, "The item should be created and fetched successfully.")
    XCTAssertEqual(items.count, 1, "There should be exactly one item in the store.")

    if let firstItem = items.first {
      XCTAssertEqual(firstItem.timestamp, newDate, "The item's timestamp should match the newDate.")
    } else {
      XCTFail("Expected to find an item but none was found.")
    }
  }
}
