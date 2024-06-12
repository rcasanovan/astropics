import Dependencies
import XCTest

@testable import AstroPics

class AstronomyPicturesUseCaseTests: XCTestCase {
  func testFetchAstronomyPicturesSuccess() async {
    // Given
    var dependencies = DependencyValues()
    dependencies.apiClient = APIClient.mock
    let useCase: AstronomyPicturesUseCase = withDependencies {
      $0 = dependencies
    } operation: {
      AstronomyPicturesUseCaseImpl()
    }

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
    var dependencies = DependencyValues()
    dependencies.apiClient = APIClient.failureMock
    let useCase: AstronomyPicturesUseCase = withDependencies {
      $0 = dependencies
    } operation: {
      AstronomyPicturesUseCaseImpl()
    }

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
