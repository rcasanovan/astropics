import Foundation

public struct AstronomyPictureModel: Equatable, Identifiable, Hashable, Sendable {
  public let id: String
  let date: String?
  let title: String
  let url: URL?
  let contentType: AstronomyPictureModelContentType
  let explanation: String

  enum AstronomyPictureModelContentType {
    case image
    case video
    case other
  }
}

// MARK: Errors
extension AstronomyPictureModel {
  public enum Error: Swift.Error, Equatable {
    case cannotLoadPictures(error: String)
  }
}
