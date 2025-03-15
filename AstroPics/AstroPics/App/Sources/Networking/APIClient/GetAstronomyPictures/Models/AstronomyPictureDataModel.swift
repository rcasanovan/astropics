import Foundation

public struct AstronomyPictureDataModel: Decodable, Sendable {
  public let date: String
  public let title: String
  public let url: URL?
  public let media_type: MediaType
  public let explanation: String

  public enum MediaType: String, Decodable, Sendable {
    case image = "image"
    case video = "video"
    case other = "other"
  }
}
