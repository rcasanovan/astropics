import Foundation

protocol APIProtocol {
  func getAstronomyPicturesURL(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  >
}

class API: APIProtocol {
  let baseAPI: BaseAPI

  init(baseAPI: BaseAPI) {
    self.baseAPI = baseAPI
  }

  func getAstronomyPicturesURL(startDate: String, endDate: String) async -> Result<
    [AstronomyPictureDataModel], APIError
  > {
    await baseAPI.sendRequest(
      url: baseAPI.getAstronomyPicturesURL(startDate: startDate, endDate: endDate),
      responseModel: [AstronomyPictureDataModel].self
    )
  }
}
