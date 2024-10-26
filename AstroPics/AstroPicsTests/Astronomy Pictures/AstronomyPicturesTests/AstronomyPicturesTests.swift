import ComposableArchitecture
import SwiftUI
import XCTest

@testable import AstroPics

final class AstronomyPicturesTests: XCTestCase {
  @MainActor
  func testOnAppearDidReceiveAstronomyPictures() async {
    // Given
    let locale = Locale(identifier: "en_US")
    let useCase = AstronomyPicturesUseCaseImpl(
      apiClient: APIClient.mock,
      locale: locale
    )

    let store = TestStore(
      initialState: AstronomyPictures.State(networkState: .ready)
    ) {
      AstronomyPictures(astronomyPicturesUseCase: useCase)
    }

    // When
    await store.send(.onAppear) {
      $0.networkState = .loading
    }

    let apiDataModelResponse: [AstronomyPictureDataModel] = .mock

    let astronomyPictures: [AstronomyPicture] =
      apiDataModelResponse.filter { $0.media_type != .other }
      .map {
        let combinedID =
          "\($0.date)\($0.title)\($0.explanation)"

        let hashID = combinedID.hash

        return AstronomyPicture(
          id: String(hashID),
          date: Date.transformDateStringToCurrentLocale($0.date, locale: locale),
          title: $0.title,
          url: $0.url,
          hasVideoContent: $0.media_type == .video,
          explanation: $0.explanation
        )
      }
      .reversed()

    // Then
    await store.receive(.didReceiveAstronomyPictures(astronomyPictures)) {
      $0.networkState = .completed(.success(astronomyPictures))
    }
  }

  @MainActor
  func testOnAppearDidReceiveError() async {
    // Given
    let locale = Locale(identifier: "en_US")
    let useCase = AstronomyPicturesUseCaseImpl(
      apiClient: APIClient.failureMock,
      locale: locale
    )

    let store = TestStore(
      initialState: AstronomyPictures.State(networkState: .ready)
    ) {
      AstronomyPictures(astronomyPicturesUseCase: useCase)
    }

    // When
    await store.send(.onAppear) {
      $0.networkState = .loading
    }

    // Then
    await store.receive(
      .didReceiveError(.cannotLoadPictures(error: "The operation couldn’t be completed. (AstroPics.APIError error 0.)"))
    ) {
      $0.networkState = .completed(
        .failure(.cannotLoadPictures(error: "The operation couldn’t be completed. (AstroPics.APIError error 0.)"))
      )
    }
  }
}
