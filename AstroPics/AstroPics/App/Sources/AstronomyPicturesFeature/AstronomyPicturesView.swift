import AstronomyPictureDetailFeature
import ComposableArchitecture
import Networking
import SwiftUI

public struct AstronomyPicturesView: View {
  @Environment(\.isLoadingImagesEnabled) private var isLoadingImagesEnabled

  private var store: StoreOf<AstronomyPictures>

  public init(store: StoreOf<AstronomyPictures>) {
    self.store = store
  }

  @ViewBuilder
  private var content: some View {
    switch store.networkState {
    case .loading:
      placeholder()
    case let .completed(.success(astronomyPictures)):
      success(with: astronomyPictures)
    case let .completed(.failure(error)):
      VStack {
        Spacer()
        ErrorView(
          error: error.localizedDescription,
          didTapOnReload: {
            store.send(.didTapOnRefresh)
          }
        )
        Spacer()
      }
    case .ready:
      Color.clear
    }
  }

  public var body: some View {
    content
      .onAppear {
        store.send(.onAppear)
      }
  }
}

// MARK: - Factory

extension AstronomyPicturesView {
  public static func make() -> Self {
    AstronomyPicturesView(
      store: .init(
        initialState: .init(networkState: .ready)
      ) {
        AstronomyPictures(
          astronomyPicturesUseCase: AstronomyPicturesUseCaseImpl(
            apiClient: APIClient.live,
            locale: Locale.current
          )
        )
      }
    )
  }
}

// MARK: - Constants

extension AstronomyPicturesView {
  enum Placeholder {
    static let shortText = "Lorem ipsum"
    static let longText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
  }
}

// MARK: - States & helpers

extension AstronomyPicturesView {
  fileprivate func placeholder() -> some View {
    ZStack(alignment: .top) {
      ScrollView {
        VStack(spacing: 0) {
          Spacer().frame(height: 75)

          ForEach(0..<10) { index in
            AstronomyPictureView(
              astronomyPicture:
                .init(
                  id: String(index),
                  date: Placeholder.shortText,
                  title: Placeholder.longText,
                  url: nil,
                  contentType: .image,
                  explanation: Placeholder.longText
                ),
              isLoadingImagesEnabled: isLoadingImagesEnabled
            )
            .redacted(reason: .placeholder)

            separator()
          }
        }
      }
      .disabled(true)

      // Sticky Header
      HeaderView()
        .background(Color.black)
    }
  }

  fileprivate func success(with astronomyPictures: [AstronomyPictureModel]) -> some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      NavigationView {
        ZStack(alignment: .top) {
          // Scrollable content
          ScrollView {
            VStack(spacing: 0) {
              Spacer().frame(height: 75)

              if viewStore.isRefreshing {
                ProgressView()
                  .tint(.white)
                  .scaleEffect(1.5)
                  .padding()
              }

              ForEach(astronomyPictures, id: \.self) { item in
                let contentType: AstronomyPictureDetailModel.AstronomyPictureDetailModelContentType =
                  switch item.contentType {
                  case .video: .video
                  case .image: .image
                  default: .other
                  }

                NavigationLink(
                  destination: AstronomyPictureDetailView.make(
                    astronomyPicture: AstronomyPictureDetailModel(
                      url: item.url,
                      contentType: contentType,
                      explanation: item.explanation
                    )
                  )
                ) {
                  AstronomyPictureView(astronomyPicture: item, isLoadingImagesEnabled: isLoadingImagesEnabled)
                }
                separator()
              }
            }
          }
          .refreshable {
            DispatchQueue.main.async {
              viewStore.send(.didReload)
            }
          }
          // Sticky Header
          HeaderView()
            .background(.black)
        }
        .background(.black)
      }
    }
  }

  fileprivate func separator() -> some View {
    Divider()
      .frame(height: 1)
      .background(.white)
  }
}

#if DEBUG

// MARK: Previews

struct AstronomyPicturesView_Preview {
  struct Preview: View {
    var store: Store<AstronomyPictures.State, AstronomyPictures.Action>
    var body: some View {
      AstronomyPicturesView(store: store)
    }
  }
}

#Preview {
  let store: Store<AstronomyPictures.State, AstronomyPictures.Action> = .init(
    initialState: .success
  ) {
    AstronomyPictures(
      astronomyPicturesUseCase: AstronomyPicturesUseCaseImpl(
        apiClient: APIClient.mock,
        locale: Locale(identifier: "en_US")
      )
    )
  }
  AstronomyPicturesView(store: store)
}

#Preview {
  let store: Store<AstronomyPictures.State, AstronomyPictures.Action> = .init(
    initialState: .loading
  ) {
    AstronomyPictures(
      astronomyPicturesUseCase: AstronomyPicturesUseCaseImpl(
        apiClient: APIClient.mock,
        locale: Locale(identifier: "en_US")
      )
    )
  }
  AstronomyPicturesView(store: store)
}

#Preview {
  let store: Store<AstronomyPictures.State, AstronomyPictures.Action> = .init(
    initialState: .failure
  ) {
    AstronomyPictures(
      astronomyPicturesUseCase: AstronomyPicturesUseCaseImpl(
        apiClient: APIClient.mock,
        locale: Locale(identifier: "en_US")
      )
    )
  }
  AstronomyPicturesView(store: store)
}

#endif
