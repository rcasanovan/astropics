import Foundation

public protocol APIClientProtocol {
  func getAstronomyPicturesURL(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  >
}

public class APIClient: APIClientProtocol {
  private let api: APIProtocol

  init(api: APIProtocol) {
    self.api = api
  }

  public func getAstronomyPicturesURL(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  > {
    await api.getAstronomyPicturesURL(startDate: startDate, endDate: endDate)
  }
}
