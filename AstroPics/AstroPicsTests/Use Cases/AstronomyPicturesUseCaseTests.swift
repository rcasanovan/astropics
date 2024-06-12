import Dependencies
import XCTest

@testable import AstroPics

class AstronomyPicturesUseCaseTests: XCTestCase {
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
      XCTAssertEqual(pictures.count, 7)
    case .failure:
      XCTFail("Expected success but got failure")
    }
  }

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
      XCTFail("Expected failure but got success")
    case .failure(let error):
      XCTAssertEqual(error, .serverError(code: 999))
    }
  }
}
