import ComposableArchitecture
import Foundation

public struct AstronomyPicture: Equatable, Identifiable {
  public let id: String
  let date: String
  let title: String
  let url: String
}

public protocol AstronomyPicturesUseCase {
  func fetchAstronomyPictures() -> Effect<Result<[AstronomyPicture], APIError>>
}

public struct AstronomyPicturesUseCaseImpl: AstronomyPicturesUseCase {
  @Dependency(\.apiClient) var apiClient

  public func fetchAstronomyPictures() -> Effect<Result<[AstronomyPicture], APIError>> {
    return .run { send in
      let result = await apiClient.getAstronomyPictures(startDate: "2024-01-01", endDate: "2024-01-07")
      switch result {
      case .success(let astronomyPicturesData):
        let items = astronomyPicturesData.map {
          AstronomyPicture(id: $0.url, date: $0.date, title: $0.title, url: $0.url)
        }
        return await send(.success(items))
      case .failure(let error):
        return await send(.failure(error))
      }
    } catch: { error, send in
      // Assuming `error` can be cast to `APIError`
      if let apiError = error as? APIError {
        return await send(.failure(apiError))
      } else {
        return await send(.failure(.unknown))
      }
    }
  }
}
