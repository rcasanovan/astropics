//
//  AstronomyPictureDetail.swift
//  AstroPics
//
//  Created by Ricardo Casanova on 12/6/24.
//

import ComposableArchitecture
import Foundation
import SwiftUI

public struct AstronomyPictureDetail: Reducer {
  //__ The basic state. Feel free to change this if needed.
  public struct State: Equatable {
    public let astronomyPicture: AstronomyPicture
  }

  //__ The basic actions. Feel free to change this if needed.
  public enum Action: Equatable {
    case didTapOnPlayVideo
  }

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .didTapOnPlayVideo:
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
