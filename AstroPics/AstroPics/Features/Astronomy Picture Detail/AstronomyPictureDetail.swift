import ComposableArchitecture
import Foundation
import SwiftUI

public struct AstronomyPictureDetail: Reducer {
  public struct State: Equatable {
    public let astronomyPicture: AstronomyPicture
  }

  public enum Action: Equatable {
    case didTapOnLoadContent
  }

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .didTapOnLoadContent:
        guard let url = state.astronomyPicture.url else {
          return .none
        }

        openURLInBrowser(url: url)
        return .none
      }
    }
  }
}

extension AstronomyPictureDetail {
  fileprivate func openURLInBrowser(url: URL) {
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
}
