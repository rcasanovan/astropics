//
//  AstronomyPictureDetailView.swift
//  AstroPics
//
//  Created by Ricardo Casanova on 12/6/24.
//

import ComposableArchitecture
import SwiftUI

struct AstronomyPictureDetailView: View {
  private let pictureGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.4)])

  @State private var scale: CGFloat = 1.0

  private var store: Store<AstronomyPictureDetail.State, AstronomyPictureDetail.Action>

  public init(store: Store<AstronomyPictureDetail.State, AstronomyPictureDetail.Action>) {
    self.store = store
  }

  @ViewBuilder
  private var content: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ZStack {
        if let url = viewStore.astronomyPicture.url {
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
                Text("Failed to load image")
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .background(Color.white)
              case .empty:
                Color.white
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
              @unknown default:
                // Handle unknown state
                EmptyView()
              }
            }
          }
        } else {
          Color.gray
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }

        if viewStore.astronomyPicture.url != nil {
          LinearGradient(
            gradient: pictureGradient,
            startPoint: .top,
            endPoint: .bottom
          )
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        }

        VStack(alignment: .leading, spacing: 8) {
          Spacer()

          separator()

          Text(viewStore.astronomyPicture.explanation)
            .foregroundColor(.white)
            .font(.footnote)
            .padding(.horizontal, 24)

          separator()
        }
        .padding(.bottom, 64)
      }
    }
  }

  //__ This is the body for the view
  var body: some View {
    content
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

#Preview {
  let store: Store<AstronomyPictureDetail.State, AstronomyPictureDetail.Action> = .init(
    initialState: AstronomyPictureDetail.State(
      astronomyPicture: .init(
        id: "_id_0_",
        date: "2024-01-01",
        title: "NGC 1232: A Grand Design Spiral Galaxy",
        url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
        hasVideoContent: false,
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
