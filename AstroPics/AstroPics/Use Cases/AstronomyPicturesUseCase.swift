import Foundation

public struct AstronomyPicture: Equatable, Identifiable, Hashable {
  public let id: String
  let date: String?
  let title: String
  let url: URL?
  let hasVideoContent: Bool
  let explanation: String
}

// MARK: Errors
extension AstronomyPicture {
  public enum Error: Swift.Error, Equatable {
    case cannotLoadPictures(error: String)
  }
}

public protocol AstronomyPicturesUseCase {
  func fetchAstronomyPictures() async -> Result<[AstronomyPicture], AstronomyPicture.Error>
}

public struct AstronomyPicturesUseCaseImpl: AstronomyPicturesUseCase {
  let apiClient: APIClientProtocol
  let locale: Locale

  public func fetchAstronomyPictures() async -> Result<[AstronomyPicture], AstronomyPicture.Error> {
    do {
      let result = await apiClient.getAstronomyPictures(
        startDate: Date.formattedDateDaysAgo(7),
        endDate: Date.formattedDateDaysAgo(1)
      )

      switch result {
      case .success(let dataModels):
        let pictures = dataModels.filter { $0.media_type != .other }
          .map { dataModel in
            let combinedID =
              "\(dataModel.date)\(dataModel.title)\(dataModel.explanation)"

            // Hash the combined string to produce a unique identifier
            let hashID = combinedID.hash

            return AstronomyPicture(
              id: String(hashID),
              date: Date.transformDateStringToCurrentLocale(dataModel.date, locale: locale),
              title: dataModel.title,
              url: dataModel.url,
              hasVideoContent: dataModel.media_type == .video,
              explanation: dataModel.explanation
            )
          }
        return .success(pictures.reversed())
      case .failure(let error):
        return .failure(.cannotLoadPictures(error: error.localizedDescription))
      }
    }
  }
}
