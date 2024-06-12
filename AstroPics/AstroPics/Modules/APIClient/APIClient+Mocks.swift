import Foundation

#if DEBUG

class APIMock: APIProtocol {
  func getAstronomyPicturesURL(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  > {
    return .success(.mock)
  }
}

class APIErrorMock: APIProtocol {
  func getAstronomyPicturesURL(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  > {
    return .failure(.serverError(code: 999))
  }
}

extension APIClient {
  static let mock = APIClient(api: APIMock())
  static let failureMock = APIClient(api: APIErrorMock())
}

#endif
