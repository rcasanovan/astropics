import ComposableArchitecture
import SnapshotTesting
import SnapshotTestingUtils
import SwiftUI
import Testing

@testable import AstronomyPictureDetailFeature

struct AstronomyPictureDetailViewTests {
  var record: SnapshotTestingConfiguration.Record

  init() {
    record = .never
  }

  @Test @MainActor
  func testAstronomyPictureDetailViewWithImage() {
    let astronomyPicture = AstronomyPictureDetailModel(
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
      contentType: .image,
      explanation:
        "Can a rocket make the Moon ripple? No, but it can make a background moon appear wavy.  The rocket, in this case, was a SpaceX Falcon Heavy that blasted off from NASA's Kennedy Space Center last week. In the featured launch picture, the rocket's exhaust plume glows beyond its projection onto the distant, rising, and nearly full moon.  Oddly, the Moon's lower edge shows unusual drip-like ripples. The Moon itself, far in the distance, was really unchanged.  The physical cause of these apparent ripples was pockets of relatively hot or rarefied air deflecting moonlight less strongly than pockets of relatively cool or compressed air: refraction. Although the shot was planned, the timing of the launch had to be just right for the rocket to be transiting the Moon during this single exposure."
    )

    let store = Store<AstronomyPictureDetail.State, AstronomyPictureDetail.Action>(
      initialState: AstronomyPictureDetail.State(astronomyPicture: astronomyPicture)
    ) {
      AstronomyPictureDetail()
    }

    let view =
      AstronomyPictureDetailView_Preview.Preview(
        store: store
      )
      .environment(\.isLoadingImagesEnabled, false)

    withSnapshotTesting(record: record) {
      assertSnapshot(of: view.colorScheme(.light), as: .deviceImage(), named: "light")
      assertSnapshot(of: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
    }
  }

  @Test @MainActor
  func testAstronomyPictureDetailViewWithVideo() {
    let astronomyPicture = AstronomyPictureDetailModel(
      url: URL(string: "https://www.youtube.com/embed/PpyPgJHKxSw?rel=0")!,
      contentType: .video,
      explanation:
        "Can a rocket make the Moon ripple? No, but it can make a background moon appear wavy.  The rocket, in this case, was a SpaceX Falcon Heavy that blasted off from NASA's Kennedy Space Center last week. In the featured launch picture, the rocket's exhaust plume glows beyond its projection onto the distant, rising, and nearly full moon.  Oddly, the Moon's lower edge shows unusual drip-like ripples. The Moon itself, far in the distance, was really unchanged.  The physical cause of these apparent ripples was pockets of relatively hot or rarefied air deflecting moonlight less strongly than pockets of relatively cool or compressed air: refraction. Although the shot was planned, the timing of the launch had to be just right for the rocket to be transiting the Moon during this single exposure."
    )

    let store = Store<AstronomyPictureDetail.State, AstronomyPictureDetail.Action>(
      initialState: AstronomyPictureDetail.State(astronomyPicture: astronomyPicture)
    ) {
      AstronomyPictureDetail()
    }

    let view =
      AstronomyPictureDetailView_Preview.Preview(
        store: store
      )
      .environment(\.isLoadingImagesEnabled, false)

    withSnapshotTesting(record: record) {
      assertSnapshot(of: view.colorScheme(.light), as: .deviceImage(), named: "light")
      assertSnapshot(of: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
    }
  }
}
