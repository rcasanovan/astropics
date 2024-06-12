import Foundation

public struct AstronomyPicture: Equatable, Identifiable, Hashable {
  public let id: String
  let date: String?
  let title: String
  let url: URL?
  let hasVideoContent: Bool
  let explanation: String
}

public protocol AstronomyPicturesUseCase {
  func fetchAstronomyPictures() async -> Result<[AstronomyPicture], APIError>
}

public struct AstronomyPicturesUseCaseImpl: AstronomyPicturesUseCase {
  let apiClient: APIClientProtocol
  let locale: Locale

  public func fetchAstronomyPictures() async -> Result<[AstronomyPicture], APIError> {
    do {
      let result = await apiClient.getAstronomyPictures(
        startDate: Date.formattedDateDaysAgo(7),
        endDate: Date.formattedDateDaysAgo(1)
      )

      switch result {
      case .success(let dataModels):
        let pictures = dataModels.map { dataModel in
          AstronomyPicture(
            id: dataModel.url.absoluteString,
            date: Date.transformDateStringToCurrentLocale(dataModel.date, locale: locale),
            title: dataModel.title,
            url: dataModel.url,
            hasVideoContent: dataModel.media_type == .video,
            explanation: dataModel.explanation
          )
        }
        return .success(pictures.reversed())
      case .failure(let error):
        return .failure(error)
      }
    }
  }
}
