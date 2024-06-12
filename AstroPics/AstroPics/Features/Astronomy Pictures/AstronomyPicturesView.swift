//
//  AstronomyPicturesView.swift
//  AstroPics
//
//  Created by Ricardo Casanova on 12/6/24.
//

import ComposableArchitecture
import SwiftUI

struct AstronomyPicturesView: View {
  private var store: Store<AstronomyPictures.State, AstronomyPictures.Action>

  public init(store: Store<AstronomyPictures.State, AstronomyPictures.Action>) {
    self.store = store
  }

  @ViewBuilder
  //__ This content view
  private var content: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      switch viewStore.networkState {
      case .loading:
        placeholder()
      case let .completed(.success(astronomyPictures)):
        success(with: astronomyPictures)
      case let .completed(.failure(error)):
        EmptyView()
        Color.red
      case .ready:
        Color.clear
      }
    }
  }

  //__ This is the body for the view
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      content
        .onAppear {
          store.send(.onAppear)
        }
    }
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
    ScrollView {
      VStack(spacing: 0) {
        ForEach(0..<10) { index in
          AstronomyPictureView(
            astronomyPicture:
              .init(
                id: String(index),
                date: Placeholder.shortText,
                title: Placeholder.longText,
                url: nil,
                hasVideoContent: false,
                explanation: Placeholder.longText
              )
          )
          .redacted(reason: .placeholder)

          separator()
        }
      }
    }
    .disabled(true)
  }

  fileprivate func success(with astronomyPictures: [AstronomyPicture]) -> some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 0) {
          ForEach(astronomyPictures, id: \.self) { item in
            NavigationLink(
              destination:
                AstronomyPictureDetailView(
                  store: .init(
                    initialState: AstronomyPictureDetail.State(astronomyPicture: item)
                  ) {
                    AstronomyPictureDetail()
                  }
                )
            ) {
              AstronomyPictureView(astronomyPicture: item)
            }
            separator()
          }
        }
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
  return AstronomyPicturesView(store: store)
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
  return AstronomyPicturesView(store: store)
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
  return AstronomyPicturesView(store: store)
}

#endif
