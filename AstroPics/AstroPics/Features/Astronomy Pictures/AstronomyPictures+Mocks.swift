import ComposableArchitecture
import Foundation

#if DEBUG

extension AstronomyPictures.State {
  static let loading = Self(networkState: .loading)

  static let success = Self(networkState: .completed(.success(.mock)))

  static let failure = Self(networkState: .completed(.failure(.cannotLoadPictures(error: "error"))))
}

extension Array where Element == AstronomyPicture {
  static let mock = Self([
    .init(
      id: "_id_0_",
      date: "2024-01-01",
      title: "NGC 1232: A Grand Design Spiral Galaxy",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg")!,
      hasVideoContent: false
    ),
    .init(
      id: "_id_1_",
      date: "2024-01-02",
      title: "Rocket Transits Rippling Moon",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/FalconMoon_Madow_960.jpg")!,
      hasVideoContent: false
    ),
    .init(
      id: "_id_2_",
      date: "2024-01-03",
      title: "A SAR Arc from New Zealand",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/SarArcNz_McDonald_960.jpg")!,
      hasVideoContent: false
    ),
    .init(
      id: "_id_3_",
      date: "2024-01-04",
      title: "Zeta Oph: Runaway Star",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/ZetaOph_spitzer_960.jpg")!,
      hasVideoContent: false
    ),
    .init(
      id: "_id_4_",
      date: "2024-01-05",
      title: "Trapezium: At the Heart of Orion",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/Image964_1024.jpg")!,
      hasVideoContent: false
    ),
    .init(
      id: "_id_5_",
      date: "2024-01-06",
      title: "The Snows of Churyumov-Gerasimenko",
      url: URL(string: "https://www.youtube.com/embed/PpyPgJHKxSw?rel=0")!,
      hasVideoContent: true
    ),
    .init(
      id: "_id_6_",
      date: "2024-01-07",
      title: "The Cat's Eye Nebula in Optical and X-ray",
      url: URL(string: "https://apod.nasa.gov/apod/image/2401/CatsEye_HubblePohl_960.jpg")!,
      hasVideoContent: false
    ),
  ]
  )
}

#endif
