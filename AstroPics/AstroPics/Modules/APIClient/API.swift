import Foundation

public protocol APIProtocol {
  func getAstronomyPicturesURL(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  >
}

public class API: APIProtocol {
  let baseAPI: BaseAPI

  init(baseAPI: BaseAPI) {
    self.baseAPI = baseAPI
  }

  public func getAstronomyPicturesURL(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  > {
    await baseAPI.sendRequest(
      url: baseAPI.getAstronomyPicturesURL(startDate: startDate, endDate: endDate),
      responseModel: [AstronomyPictureDataModel].self
    )
  }
}
