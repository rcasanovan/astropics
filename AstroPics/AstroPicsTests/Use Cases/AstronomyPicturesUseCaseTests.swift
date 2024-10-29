import Dependencies
import Foundation
import Testing

@testable import AstroPics

struct AstronomyPicturesUseCaseTests {
  @Test
  func testFetchAstronomyPicturesSuccess() async {
    // Given
    let useCase = AstronomyPicturesUseCaseImpl(
      apiClient: APIClient.mock,
      locale: Locale(identifier: "en_US")
    )

    // When
    let result = await useCase.fetchAstronomyPictures()

    // Then
    switch result {
    case .success(let pictures):
      #expect(pictures.count == 6)
    case .failure:
      #expect(Bool(false), "Expected success but got failure")
    }
  }

  @Test
  func testFetchAstronomyPicturesFailure() async {
    // Given
    let useCase = AstronomyPicturesUseCaseImpl(
      apiClient: APIClient.failureMock,
      locale: Locale(identifier: "en_US")
    )

    // When
    let result = await useCase.fetchAstronomyPictures()

    // Then
    switch result {
    case .success:
      #expect(Bool(false), "Expected failure but got success")
    case .failure(let error):
      #expect(
        error == .cannotLoadPictures(error: "The operation couldn’t be completed. (AstroPics.APIError error 0.)")
      )
    }
  }
}
