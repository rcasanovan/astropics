import Foundation

extension BaseAPI {
  private enum Constants {
    static let scheme = "https"
    static let baseUrl = "api.nasa.gov"
    static let path = "/planetary/apod"

    enum Parameters {
      static let apiKey = "api_key"
      static let startDate = "start_date"
      static let endDate = "end_date"
    }
  }

  func getAstronomyPicturesURL(startDate: String, endDate: String) -> URL? {
    var components = URLComponents()
    components.scheme = Constants.scheme
    components.host = Constants.baseUrl
    components.path = Constants.path
    components.queryItems = [
      URLQueryItem(name: Constants.Parameters.apiKey, value: "jDP6589RjEUaYCoCD0O74hGjvbEQASdnNMANRKH4"),
      URLQueryItem(name: Constants.Parameters.startDate, value: startDate),
      URLQueryItem(name: Constants.Parameters.endDate, value: endDate),
    ]
    return components.url
  }
}
