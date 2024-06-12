//
//  AstroPicsApp.swift
//  AstroPics
//
//  Created by Ricardo Casanova on 12/6/24.
//

import SwiftUI

@main
struct AstroPicsApp: App {
  var body: some Scene {
    WindowGroup {
      AstronomyPicturesView(
        store: .init(
          initialState: AstronomyPictures.State()
        ) {
          AstronomyPictures(astronomyPicturesUseCase: AstronomyPicturesUseCaseImpl())
        }
      )
    }
  }
}
