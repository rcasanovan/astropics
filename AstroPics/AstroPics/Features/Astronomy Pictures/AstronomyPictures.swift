import ComposableArchitecture
import Foundation

public struct AstronomyPictures: Reducer {
  public struct State: Equatable {
    /// The current network state for the feature
    public var networkState: NetworkState<[AstronomyPicture], AstronomyPicture.Error>

    public init(networkState: NetworkState<[AstronomyPicture], AstronomyPicture.Error>) {
      self.networkState = networkState
    }
  }

  public enum Action: Equatable {
    case didReceiveAstronomyPictures([AstronomyPicture])
    case didReceiveError(AstronomyPicture.Error)
    case didTapOnRefresh
    case onAppear
  }

  private let astronomyPicturesUseCase: AstronomyPicturesUseCase

  public init(astronomyPicturesUseCase: AstronomyPicturesUseCase) {
    self.astronomyPicturesUseCase = astronomyPicturesUseCase
  }

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .didReceiveAstronomyPictures(let astronomycPictures):
        state.networkState = .completed(.success(astronomycPictures))
        return .none

      case .didReceiveError(let error):
        state.networkState = .completed(.failure(error))
        return .none

      case .didTapOnRefresh:
        state.networkState = .loading
        return self.loadEffect()

      case .onAppear:
        guard case .ready = state.networkState else {
          return .none
        }

        state.networkState = .loading
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
        return await send(.didReceiveError(error))
      }
    } catch: { error, send in
      return await send(.didReceiveError(.cannotLoadPictures(error: error.localizedDescription)))
    }
  }
}
