//
//  AstronomyPictureDetailView.swift
//  AstroPics
//
//  Created by Ricardo Casanova on 12/6/24.
//

import ComposableArchitecture
import SwiftUI

struct AstronomyPictureDetailView: View {
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

        VStack(alignment: .leading, spacing: 8) {
          Spacer()

          Divider().background(Color.white).padding(.horizontal, 24)

          Text(
            "Finally, it's here: Newest and latest information about something very interesting."
          )
          .foregroundColor(.white)
          .padding(.horizontal, 24)
          .fixedSize(horizontal: false, vertical: true)  // Allow text wrapping

          Divider().background(Color.white).padding(.horizontal, 24)
        }
        .padding(.bottom, 64)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        // Adjust top padding to avoid overlap with status bar
      }
    }
  }

  //__ This is the body for the view
  var body: some View {
    content
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
        hasVideoContent: false
      )
    )
  ) {
    AstronomyPictureDetail()
  }
  return AstronomyPictureDetailView(store: store)
}

#endif
