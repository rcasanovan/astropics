import Foundation

public struct AstronomyPicture: Equatable, Identifiable {
  public let id: String
  let date: String
  let title: String
  let url: String
}

public protocol AstronomyPicturesUseCase {
  func fetchAstronomyPictures() async -> Result<[AstronomyPicture], APIError>
}

public struct AstronomyPicturesUseCaseImpl: AstronomyPicturesUseCase {
  let apiClient: APIClientProtocol

  public func fetchAstronomyPictures() async -> Result<[AstronomyPicture], APIError> {
    do {
      let result = await apiClient.getAstronomyPictures(startDate: "2024-01-01", endDate: "2024-01-07")

      switch result {
      case .success(let dataModels):
        let pictures = dataModels.map { dataModel in
          AstronomyPicture(id: dataModel.url, date: dataModel.date, title: dataModel.title, url: dataModel.url)
        }
        return .success(pictures)
      case .failure(let error):
        return .failure(error)
      }
    }
  }
}
