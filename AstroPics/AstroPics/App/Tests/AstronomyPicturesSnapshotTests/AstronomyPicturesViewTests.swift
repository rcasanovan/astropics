import ComposableArchitecture
import Networking
import SnapshotTesting
import SnapshotTestingUtils
import SwiftUI
import Testing

@testable import AstronomyPicturesFeature

struct AstronomyPicturesViewTests {
  var record: SnapshotTestingConfiguration.Record

  init() {
    record = .never
  }

  @Test @MainActor
  func testAstronomyPicturesViewLoadingState() {
    let locale = Locale(identifier: "en_US")
    let useCase = AstronomyPicturesUseCaseImpl(
      apiClient: APIClient.mock,
      locale: locale
    )
    let store = Store<AstronomyPictures.State, AstronomyPictures.Action>(
      initialState: .loading
    ) {
      AstronomyPictures(astronomyPicturesUseCase: useCase)
    }

    let view =
      AstronomyPicturesView_Preview.Preview(
        store: store
      )

    withSnapshotTesting(record: record) {
      assertSnapshot(of: view.colorScheme(.light), as: .deviceImage(), named: "light")
      assertSnapshot(of: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
    }
  }

  @Test @MainActor
  func testAstronomyPicturesViewSuccessState() {
    let locale = Locale(identifier: "en_US")
    let useCase = AstronomyPicturesUseCaseImpl(
      apiClient: APIClient.mock,
      locale: locale
    )
    let store = Store<AstronomyPictures.State, AstronomyPictures.Action>(
      initialState: .success
    ) {
      AstronomyPictures(astronomyPicturesUseCase: useCase)
    }

    let view =
      AstronomyPicturesView_Preview.Preview(
        store: store
      )
      .environment(\.isLoadingImagesEnabled, false)

    withSnapshotTesting(record: record) {
      assertSnapshot(of: view.colorScheme(.light), as: .deviceImage(), named: "light")
      assertSnapshot(of: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
    }
  }

  @Test @MainActor
  func testAstronomyPicturesViewFailureState() {
    let locale = Locale(identifier: "en_US")
    let useCase = AstronomyPicturesUseCaseImpl(
      apiClient: APIClient.mock,
      locale: locale
    )
    let store = Store<AstronomyPictures.State, AstronomyPictures.Action>(
      initialState: .failure
    ) {
      AstronomyPictures(astronomyPicturesUseCase: useCase)
    }

    let view =
      AstronomyPicturesView_Preview.Preview(
        store: store
      )

    withSnapshotTesting(record: record) {
      assertSnapshot(of: view.colorScheme(.light), as: .deviceImage(), named: "light")
      assertSnapshot(of: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
    }
  }

  @Test @MainActor
  func testAstronomyPicturesViewRefreshingState() {
    let locale = Locale(identifier: "en_US")
    let useCase = AstronomyPicturesUseCaseImpl(
      apiClient: APIClient.mock,
      locale: locale
    )
    let store = Store<AstronomyPictures.State, AstronomyPictures.Action>(
      initialState: .refreshing
    ) {
      AstronomyPictures(astronomyPicturesUseCase: useCase)
    }

    let view =
      AstronomyPicturesView_Preview.Preview(
        store: store
      )
      .environment(\.isLoadingImagesEnabled, false)

    withSnapshotTesting(record: record) {
      assertSnapshot(of: view.colorScheme(.light), as: .deviceImage(), named: "light")
      assertSnapshot(of: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
    }
  }
}
