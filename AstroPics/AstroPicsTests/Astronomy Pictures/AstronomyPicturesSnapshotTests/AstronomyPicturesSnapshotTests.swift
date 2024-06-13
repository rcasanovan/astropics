import ComposableArchitecture
import SnapshotTesting
import SwiftUI
import XCTest

@testable import AstroPics

final class AstronomyPicturesSnapshotTests: XCTestCase {
  override func setUpWithError() throws {
    //    isRecording = true
  }

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

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }

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

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }

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

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }
}
