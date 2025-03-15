import Foundation

#if DEBUG

final class APIMock: APIProtocol {
  func getAstronomyPicturesURL(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  > {
    return .success(.mock)
  }
}

final class APIErrorMock: APIProtocol {
  func getAstronomyPicturesURL(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  > {
    return .failure(.serverError(code: 999))
  }
}

extension APIClient {
  public static let mock = APIClient(api: APIMock())
  public static let failureMock = APIClient(api: APIErrorMock())
}

#endif
