import SwiftUI

private struct IsLoadingImagesEnabledKey: EnvironmentKey {
  static let defaultValue: Bool = true
}

extension EnvironmentValues {
  public var isLoadingImagesEnabled: Bool {
    get { self[IsLoadingImagesEnabledKey.self] }
    set { self[IsLoadingImagesEnabledKey.self] = newValue }
  }
}
