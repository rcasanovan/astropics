import ComposableArchitecture
import Foundation

@Reducer
public struct AstronomyPictures {
  @ObservableState
  public struct State: Equatable {
    public var isRefreshing = false
    /// The current network state for the feature
    public var networkState: NetworkState<[AstronomyPictureModel], AstronomyPictureModel.Error>

    public init(
      networkState: NetworkState<[AstronomyPictureModel], AstronomyPictureModel.Error>,
      isRefreshing: Bool = false
    ) {
      self.isRefreshing = isRefreshing
      self.networkState = networkState
    }
  }

  public enum Action: Equatable {
    case didReceiveAstronomyPictures([AstronomyPictureModel])
    case didReceiveError(AstronomyPictureModel.Error)
    case didReload
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
        state.isRefreshing = false
        state.networkState = .completed(.success(astronomycPictures))
        return .none

      case .didReceiveError(let error):
        state.isRefreshing = false
        state.networkState = .completed(.failure(error))
        return .none

      case .didReload:
        state.isRefreshing = true
        return self.loadEffect()

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
    let useCase = self.astronomyPicturesUseCase
    return .run { send in
      let result = await useCase.fetchAstronomyPictures()
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
