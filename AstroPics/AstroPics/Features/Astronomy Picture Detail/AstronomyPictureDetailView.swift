import ComposableArchitecture
import SwiftUI

struct AstronomyPictureDetailView: View {
  @Environment(\.isLoadingImagesEnabled) private var isLoadingImagesEnabled

  private let pictureGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)])

  private var store: StoreOf<AstronomyPictureDetail>

  public init(store: Store<AstronomyPictureDetail.State, AstronomyPictureDetail.Action>) {
    self.store = store

    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .black

    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }

  @ViewBuilder
  private var content: some View {
    ZStack {
      if store.astronomyPicture.contentType == .video {
        Color.black
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      } else {
        if let url = store.astronomyPicture.url, isLoadingImagesEnabled {
          GeometryReader { geometry in
            AsyncImage(url: url) { phase in
              switch phase {
              case .success(let image):
                image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: geometry.size.width, height: geometry.size.height)
                  .clipped()
              case .failure:
                Color.black
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
              case .empty:
                Color.white
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
              @unknown default:
                EmptyView()
              }
            }
          }
        } else {
          Color.gray
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
      }

      if store.astronomyPicture.url != nil {
        LinearGradient(
          gradient: pictureGradient,
          startPoint: .top,
          endPoint: .bottom
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }

      VStack(alignment: .leading, spacing: 8) {
        Spacer()

        if store.astronomyPicture.contentType == .video {
          VStack {
            Spacer()
            HStack {
              Spacer()
              Button(
                action: {
                  store.send(.didTapOnLoadContent)
                },
                label: {
                  Image("PlayIcon")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.white)
                }
              )
              Spacer()
            }
            Spacer()
          }
        }

        separator()

        Text(store.astronomyPicture.explanation)
          .foregroundColor(.white)
          .font(.footnote)
          .padding(.horizontal, 24)

        separator()
      }
      .padding(.bottom, 64)
    }
    .background(.black)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        if store.astronomyPicture.contentType == .image {
          Button(action: {
            store.send(.didTapOnLoadContent)
          }) {
            Image("FullScreenIcon")
              .foregroundColor(.white)
          }
        }
      }
    }
  }

  var body: some View {
    content
  }
}

// MARK: - Factory

extension AstronomyPictureDetailView {
  static func make(astronomyPicture: AstronomyPicture) -> Self {
    AstronomyPictureDetailView(
      store: .init(
        initialState: AstronomyPictureDetail.State(astronomyPicture: astronomyPicture)
      ) {
        AstronomyPictureDetail()
      }
    )
  }
}

// MARK: - Helpers

extension AstronomyPictureDetailView {
  fileprivate func separator() -> some View {
    Divider()
      .background(.white)
      .padding(.horizontal, 24)
  }
}

#if DEBUG

// MARK: Previews

struct AstronomyPictureDetailView_Preview {
  struct Preview: View {
    var store: Store<AstronomyPictureDetail.State, AstronomyPictureDetail.Action>
    var body: some View {
      AstronomyPictureDetailView(store: store)
    }
  }
}

/// Preview for AstronomyPicture item with image
#Preview {
  let store: Store<AstronomyPictureDetail.State, AstronomyPictureDetail.Action> = .init(
    initialState: AstronomyPictureDetail.State(
      astronomyPicture: .init(
        id: "_id_0_",
        date: "2024-01-01",
        title: "NGC 1232: A Grand Design Spiral Galaxy",
        url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
        contentType: .image,
        explanation:
          "Can a rocket make the Moon ripple? No, but it can make a background moon appear wavy.  The rocket, in this case, was a SpaceX Falcon Heavy that blasted off from NASA's Kennedy Space Center last week. In the featured launch picture, the rocket's exhaust plume glows beyond its projection onto the distant, rising, and nearly full moon.  Oddly, the Moon's lower edge shows unusual drip-like ripples. The Moon itself, far in the distance, was really unchanged.  The physical cause of these apparent ripples was pockets of relatively hot or rarefied air deflecting moonlight less strongly than pockets of relatively cool or compressed air: refraction. Although the shot was planned, the timing of the launch had to be just right for the rocket to be transiting the Moon during this single exposure."
      )
    )
  ) {
    AstronomyPictureDetail()
  }
  return AstronomyPictureDetailView(store: store)
}

/// Preview for AstronomyPicture item with video
#Preview {
  let store: Store<AstronomyPictureDetail.State, AstronomyPictureDetail.Action> = .init(
    initialState: AstronomyPictureDetail.State(
      astronomyPicture: .init(
        id: "_id_0_",
        date: "2024-01-01",
        title: "NGC 1232: A Grand Design Spiral Galaxy",
        url: URL(string: "https://www.youtube.com/embed/PpyPgJHKxSw?rel=0")!,
        contentType: .video,
        explanation:
          "Can a rocket make the Moon ripple? No, but it can make a background moon appear wavy.  The rocket, in this case, was a SpaceX Falcon Heavy that blasted off from NASA's Kennedy Space Center last week. In the featured launch picture, the rocket's exhaust plume glows beyond its projection onto the distant, rising, and nearly full moon.  Oddly, the Moon's lower edge shows unusual drip-like ripples. The Moon itself, far in the distance, was really unchanged.  The physical cause of these apparent ripples was pockets of relatively hot or rarefied air deflecting moonlight less strongly than pockets of relatively cool or compressed air: refraction. Although the shot was planned, the timing of the launch had to be just right for the rocket to be transiting the Moon during this single exposure."
      )
    )
  ) {
    AstronomyPictureDetail()
  }
  return AstronomyPictureDetailView(store: store)
}

#endif
