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
        VStack {
          ForEach(astronomyPictures, id: \.self) { item in
            if let date = item.date {
              Text(date)
            }
            Text(item.title)
              .padding()
          }
        }
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
    static let shortText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
    static let longText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
  }
}

// MARK: - Placeholder

extension AstronomyPicturesView {
  fileprivate func placeholder() -> some View {
    VStack {
      ForEach(0..<14) { _ in
        Text(Placeholder.longText)
          .redacted(reason: .placeholder)
          .padding()
      }
    }
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
