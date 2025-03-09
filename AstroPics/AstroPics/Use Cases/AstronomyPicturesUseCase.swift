import Foundation

public struct AstronomyPicture: Equatable, Identifiable, Hashable {
  public let id: String
  let date: String?
  let title: String
  let url: URL?
  let contentType: AstronomyPictureContentType
  let explanation: String

  enum AstronomyPictureContentType {
    case image
    case video
    case other
  }
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

            let contentType: AstronomyPicture.AstronomyPictureContentType =
              switch dataModel.media_type {
              case .video: .video
              case .image: .image
              default: .other
              }

            return AstronomyPicture(
              id: String(hashID),
              date: Date.transformDateStringToCurrentLocale(dataModel.date, locale: locale),
              title: dataModel.title,
              url: dataModel.url,
              contentType: contentType,
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
