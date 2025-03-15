import Foundation

public protocol APIClientProtocol: Sendable {
  func getAstronomyPictures(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  >
}

public final class APIClient: APIClientProtocol {
  private let api: APIProtocol

  init(api: APIProtocol) {
    self.api = api
  }

  public func getAstronomyPictures(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  > {
    await api.getAstronomyPicturesURL(startDate: startDate, endDate: endDate)
  }
}
