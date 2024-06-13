import SnapshotTesting
import SwiftUI
import XCTest

@testable import AstroPics

final class AstronomyPictureViewTests: XCTestCase {
  override func setUpWithError() throws {
    //    isRecording = true
  }

  func testAstronomyPictureViewWithDate() {
    let view = AstronomyPictureView(
      astronomyPicture: AstronomyPicture(
        id: "_id_0_",
        date: "2024-01-01",
        title: "NGC 1232: A Grand Design Spiral Galaxy",
        url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
        hasVideoContent: false,
        explanation:
          "Can a rocket make the Moon ripple?."
      ),
      isLoadingImagesEnabled: false
    )

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }

  func testAstronomyPictureViewWithoutDate() {
    let view = AstronomyPictureView(
      astronomyPicture: AstronomyPicture(
        id: "_id_0_",
        date: nil,
        title: "NGC 1232: A Grand Design Spiral Galaxy",
        url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
        hasVideoContent: false,
        explanation:
          "Can a rocket make the Moon ripple?."
      ),
      isLoadingImagesEnabled: false
    )

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }

  func testAstronomyPictureViewWithVideo() {
    let view = AstronomyPictureView(
      astronomyPicture: AstronomyPicture(
        id: "_id_0_",
        date: "2024-01-06",
        title: "The Snows of Churyumov-Gerasimenko",
        url: URL(string: "https://www.youtube.com/embed/PpyPgJHKxSw?rel=0")!,
        hasVideoContent: true,
        explanation:
          "Can a rocket make the Moon ripple?."
      ),
      isLoadingImagesEnabled: false
    )

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }
}
