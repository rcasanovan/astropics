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

#if DEBUG

// MARK: Previews

#Preview {
  let store: Store<AstronomyPictures.State, AstronomyPictures.Action> = .init(
    initialState: AstronomyPictures.State()
  ) {
    AstronomyPictures(astronomyPicturesUseCase: AstronomyPicturesUseCaseImpl(apiClient: APIClient.mock))
  }
  return AstronomyPicturesView(store: store)
}

#endif
