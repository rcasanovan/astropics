import Foundation
import Networking
import Utils

public protocol AstronomyPicturesUseCase: Sendable {
  func fetchAstronomyPictures() async -> Result<[AstronomyPictureModel], AstronomyPictureModel.Error>
}

public struct AstronomyPicturesUseCaseImpl: AstronomyPicturesUseCase {
  let apiClient: APIClientProtocol
  let locale: Locale

  public func fetchAstronomyPictures() async -> Result<[AstronomyPictureModel], AstronomyPictureModel.Error> {
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

            let contentType: AstronomyPictureModel.AstronomyPictureModelContentType =
              switch dataModel.media_type {
              case .video: .video
              case .image: .image
              default: .other
              }

            return AstronomyPictureModel(
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
