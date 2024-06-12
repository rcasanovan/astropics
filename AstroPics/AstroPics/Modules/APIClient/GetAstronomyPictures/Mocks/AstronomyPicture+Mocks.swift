import Foundation

#if DEBUG

extension Array where Element == AstronomyPictureDataModel {
    static let mock: Self = [
        AstronomyPictureDataModel(
            date: "2024-01-01",
            title: "NGC 1232: A Grand Design Spiral Galaxy",
            url: "https://apod.nasa.gov/apod/image/2401/ngc1232b_vlt_960.jpg"
        ),
        AstronomyPictureDataModel(
            date: "2024-01-02",
            title: "Rocket Transits Rippling Moon",
            url: "https://apod.nasa.gov/apod/image/2401/FalconMoon_Madow_960.jpg"
        ),
        AstronomyPictureDataModel(
            date: "2024-01-03",
            title: "A SAR Arc from New Zealand",
            url: "https://apod.nasa.gov/apod/image/2401/SarArcNz_McDonald_960.jpg"
        ),
        AstronomyPictureDataModel(
            date: "2024-01-04",
            title: "Zeta Oph: Runaway Star",
            url: "https://apod.nasa.gov/apod/image/2401/ZetaOph_spitzer_960.jpg"
        ),
        AstronomyPictureDataModel(
            date: "2024-01-05",
            title: "Trapezium: At the Heart of Orion",
            url: "https://apod.nasa.gov/apod/image/2401/Image964_1024.jpg"
        ),
        AstronomyPictureDataModel(
            date: "2024-01-06",
            title: "The Snows of Churyumov-Gerasimenko",
            url: "https://www.youtube.com/embed/PpyPgJHKxSw?rel=0"
        ),
        AstronomyPictureDataModel(
            date: "2024-01-07",
            title: "The Cat's Eye Nebula in Optical and X-ray",
            url: "https://apod.nasa.gov/apod/image/2401/CatsEye_HubblePohl_960.jpg"
        )
    ]
}

#endif
