import Foundation

public protocol APIClientProtocol {
  func getAstronomyPictures(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  >
}

class APIClient: APIClientProtocol {
  private let api: APIProtocol

  init(api: APIProtocol) {
    self.api = api
  }

  func getAstronomyPictures(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  > {
    await api.getAstronomyPicturesURL(startDate: startDate, endDate: endDate)
  }
}
