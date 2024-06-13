import SwiftUI

@main
struct AstroPicsApp: App {
  var body: some Scene {
    WindowGroup {
      AstronomyPicturesView(
        store: .init(
          initialState: .init(networkState: .ready)
        ) {
          AstronomyPictures(
            astronomyPicturesUseCase: AstronomyPicturesUseCaseImpl(apiClient: APIClient.live, locale: Locale.current)
          )
        }
      )
    }
  }
}
