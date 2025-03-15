import ComposableArchitecture
import Networking
import SwiftUI
import Testing

@testable import AstronomyPicturesFeature

struct AstronomyPicturesTests {
  @Test @MainActor
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

    let astronomyPictures: [AstronomyPictureModel] =
      apiDataModelResponse.filter { $0.media_type != .other }
      .map {
        let combinedID =
          "\($0.date)\($0.title)\($0.explanation)"

        let hashID = combinedID.hash

        let contentType: AstronomyPictureModel.AstronomyPictureModelContentType =
          switch $0.media_type {
          case .video: .video
          case .image: .image
          default: .other
          }

        return AstronomyPictureModel(
          id: String(hashID),
          date: Date.transformDateStringToCurrentLocale($0.date, locale: locale),
          title: $0.title,
          url: $0.url,
          contentType: contentType,
          explanation: $0.explanation
        )
      }
      .reversed()

    // Then
    await store.receive(.didReceiveAstronomyPictures(astronomyPictures)) {
      $0.networkState = .completed(.success(astronomyPictures))
    }
  }

  @Test @MainActor
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
      .didReceiveError(
        .cannotLoadPictures(error: "The operation couldn’t be completed. (Networking.APIError error 0.)")
      )
    ) {
      $0.networkState = .completed(
        .failure(.cannotLoadPictures(error: "The operation couldn’t be completed. (Networking.APIError error 0.)"))
      )
    }
  }
}
