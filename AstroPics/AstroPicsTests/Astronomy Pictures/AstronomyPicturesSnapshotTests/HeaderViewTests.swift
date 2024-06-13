import SnapshotTesting
import SwiftUI
import XCTest

@testable import AstroPics

final class HeaderViewTests: XCTestCase {
  override func setUpWithError() throws {
    //    isRecording = true
  }

  func testHeaderView() {
    let view = HeaderView_Preview.Preview()

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }
}
