import SnapshotTesting
import SwiftUI
import Testing

@testable import AstronomyPicturesFeature

struct AstronomyPictureViewTests {
  var record: SnapshotTestingConfiguration.Record

  init() {
    record = .never
  }

  @Test @MainActor
  func testAstronomyPictureViewWithDate() {
    let view = AstronomyPictureView(
      astronomyPicture: AstronomyPictureModel(
        id: "_id_0_",
        date: "2024-01-01",
        title: "NGC 1232: A Grand Design Spiral Galaxy",
        url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
        contentType: .image,
        explanation:
          "Can a rocket make the Moon ripple?."
      ),
      isLoadingImagesEnabled: false
    )

    withSnapshotTesting(record: record) {
      assertSnapshot(of: view.colorScheme(.light), as: .deviceImage(), named: "light")
      assertSnapshot(of: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
    }
  }

  @Test @MainActor
  func testAstronomyPictureViewWithoutDate() {
    let view = AstronomyPictureView(
      astronomyPicture: AstronomyPictureModel(
        id: "_id_0_",
        date: nil,
        title: "NGC 1232: A Grand Design Spiral Galaxy",
        url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
        contentType: .image,
        explanation:
          "Can a rocket make the Moon ripple?."
      ),
      isLoadingImagesEnabled: false
    )

    withSnapshotTesting(record: record) {
      assertSnapshot(of: view.colorScheme(.light), as: .deviceImage(), named: "light")
      assertSnapshot(of: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
    }
  }

  @Test @MainActor
  func testAstronomyPictureViewWithVideo() {
    let view = AstronomyPictureView(
      astronomyPicture: AstronomyPictureModel(
        id: "_id_0_",
        date: "2024-01-06",
        title: "The Snows of Churyumov-Gerasimenko",
        url: URL(string: "https://www.youtube.com/embed/PpyPgJHKxSw?rel=0")!,
        contentType: .video,
        explanation:
          "Can a rocket make the Moon ripple?."
      ),
      isLoadingImagesEnabled: false
    )

    withSnapshotTesting(record: record) {
      assertSnapshot(of: view.colorScheme(.light), as: .deviceImage(), named: "light")
      assertSnapshot(of: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
    }
  }
}
