import Testing

@testable import AstroPics

struct APIClientTests {
  @Test
  func testAPIClientGetAstronomyPicturesSuccess() async {
    // Given
    let apiClient = APIClient.mock

    // When
    let result = await apiClient.getAstronomyPictures(startDate: "2024-06-01", endDate: "2024-06-07")

    // Then
    switch result {
    case .success(let pictures):
      #expect(!pictures.isEmpty, "List should not be empty")
    case .failure(let error):
      #expect(Bool(false), "Expected success, but got failure with error: \(error)")
    }
  }

  @Test
  func testAPIClientGetAstronomyPicturesFailure() async {
    // Given
    let apiClient = APIClient.failureMock

    // When
    let result = await apiClient.getAstronomyPictures(startDate: "2024-06-01", endDate: "2024-06-07")

    // Then
    switch result {
    case .success:
      #expect(Bool(false), "Expected failure, but got success")
    case .failure(let error):
      #expect(error == .serverError(code: 999), "Expected server error with specific code")
    }
  }
}
