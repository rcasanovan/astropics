import ComposableArchitecture
import Foundation
import SwiftUI

@Reducer
public struct AstronomyPictureDetail {
  @ObservableState
  public struct State: Equatable {
    public let astronomyPicture: AstronomyPictureDetailModel
  }

  public enum Action: Equatable {
    case didTapOnLoadContent
    case openURL(URL)
  }

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .didTapOnLoadContent:
        guard let url = state.astronomyPicture.url else {
          return .none
        }

        return .send(.openURL(url))

      case .openURL(let url):
        return .run { _ in
          if await UIApplication.shared.canOpenURL(url) {
            await MainActor.run {
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
          }
        }
      }
    }
  }
}
