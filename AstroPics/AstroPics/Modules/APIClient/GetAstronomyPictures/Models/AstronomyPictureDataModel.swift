import Foundation

public struct AstronomyPictureDataModel: Decodable {
  let date: String
  let title: String
  let url: URL
  let media_type: MediaType
  let explanation: String

  enum MediaType: String, Decodable {
    case image = "image"
    case video = "video"
  }
}
