import SwiftUI

extension Image {
  internal static var NASAIcon: Image {
    .init("NASAIcon", bundle: .module)
  }

  internal static var errorIcon: Image {
    .init("ErrorIcon", bundle: .module)
  }

  internal static var playIcon: Image {
    .init("PlayIcon", bundle: .module)
  }
}
