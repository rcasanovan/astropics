import SwiftUI

private struct IsLoadingImagesEnabledKey: EnvironmentKey {
  static var defaultValue: Bool = true
}

extension EnvironmentValues {
  public var isLoadingImagesEnabled: Bool {
    get { self[IsLoadingImagesEnabledKey.self] }
    set { self[IsLoadingImagesEnabledKey.self] = newValue }
  }
}
