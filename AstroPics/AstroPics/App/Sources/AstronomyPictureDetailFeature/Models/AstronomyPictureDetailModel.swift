import Foundation

public struct AstronomyPictureDetailModel: Equatable, Hashable {
  let url: URL?
  let contentType: AstronomyPictureDetailModelContentType
  let explanation: String

  public init(url: URL?, contentType: AstronomyPictureDetailModelContentType, explanation: String) {
    self.url = url
    self.contentType = contentType
    self.explanation = explanation
  }

  public enum AstronomyPictureDetailModelContentType {
    case image
    case video
    case other
  }
}
