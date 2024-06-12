//
//  AstronomyPictures.swift
//  AstroPics
//
//  Created by Ricardo Casanova on 12/6/24.
//

import ComposableArchitecture
import Foundation

public struct AstronomyPictures: Reducer {
  //__ The basic state. Feel free to change this if needed.
  public struct State: Equatable {
    public var title = ""
  }

  //__ The basic actions. Feel free to change this if needed.
  public enum Action: Equatable {
    case didReceiveAstronomyPictures([AstronomyPicture])
    case didReceiveError(Error)
    case onAppear
  }

  private let astronomyPicturesUseCase: AstronomyPicturesUseCase

  public init(astronomyPicturesUseCase: AstronomyPicturesUseCase) {
    self.astronomyPicturesUseCase = astronomyPicturesUseCase
  }

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .didReceiveAstronomyPictures(let astronomicPictures):
        print("test")
        return .none

      case .didReceiveError(let error):
        return .none

      case .onAppear:
        return self.loadEffect()
      }
    }
  }
}

extension AstronomyPictures {
  fileprivate func loadEffect() -> Effect<AstronomyPictures.Action> {
    return .run { send in
      let result = await astronomyPicturesUseCase.fetchAstronomyPictures()
      switch result {
      case .success(let astronomyPictures):
        return await send(.didReceiveAstronomyPictures(astronomyPictures))
      case .failure(let error):
        return await send(.didReceiveError(.cannotLoadPictures(error: error.localizedDescription)))
      }
    } catch: { error, send in
      return await send(.didReceiveError(.cannotLoadPictures(error: error.localizedDescription)))
    }
  }
}

// MARK: Errors

extension AstronomyPictures {
  public enum Error: Swift.Error, Equatable {
    case cannotLoadPictures(error: String)
  }
}
