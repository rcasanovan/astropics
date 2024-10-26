import XCTest

@testable import AstroPics

final class APIClientTests: XCTestCase {
  func testAPIClientGetAstronomyPicturesSuccess() async {
    // Given
    let apiClient = APIClient.mock

    // When
    let result = await apiClient.getAstronomyPictures(startDate: "2024-06-01", endDate: "2024-06-07")

    // Then
    switch result {
    case .success(let pictures):
      XCTAssertFalse(pictures.isEmpty, "List should not be empty")
    case .failure(let error):
      XCTFail("Expected success, but got failure with error: \(error)")
    }
  }

  func testAPIClientGetAstronomyPicturesFailure() async {
    // Given
    let apiClient = APIClient.failureMock

    // When
    let result = await apiClient.getAstronomyPictures(startDate: "2024-06-01", endDate: "2024-06-07")

    // Then
    switch result {
    case .success:
      XCTFail("Expected failure, but got success")
    case .failure(let error):
      XCTAssertEqual(error, .serverError(code: 999), "Expected server error with specific code")
    }
  }
}
