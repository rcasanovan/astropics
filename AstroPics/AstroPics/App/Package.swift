// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "App",
  platforms: [
    .iOS(.v18)
  ],
  products: [
    .library(name: "AstronomyPictureDetailFeature", targets: ["AstronomyPictureDetailFeature"]),
    .library(name: "AstronomyPicturesFeature", targets: ["AstronomyPicturesFeature"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMinor(from: "1.18.0")),
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", .upToNextMajor(from: "1.18.1")),
  ],
  targets: [
    .target(
      name: "AstronomyPictureDetailFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "Utils",
      ]
    ),
    .testTarget(
      name: "AstronomyPictureDetailFeatureTests",
      dependencies: [
        "AstronomyPictureDetailFeature"
      ]
    ),
    .testTarget(
      name: "AstronomyPictureDetailSnapshotTests",
      dependencies: [
        "AstronomyPictureDetailFeature",
        "SnapshotTestingUtils",
      ]
    ),
    .target(
      name: "AstronomyPicturesFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "AstronomyPictureDetailFeature",
        "Networking",
        "Utils",
      ]
    ),
    .testTarget(
      name: "AstronomyPicturesFeatureTests",
      dependencies: [
        "AstronomyPicturesFeature",
        "Networking",
      ]
    ),
    .testTarget(
      name: "AstronomyPicturesSnapshotTests",
      dependencies: [
        "AstronomyPicturesFeature",
        "Networking",
        "SnapshotTestingUtils",
      ]
    ),
    .target(
      name: "Networking"
    ),
    .testTarget(
      name: "NetworkingTests",
      dependencies: [
        "Networking"
      ]
    ),
    .target(
      name: "Utils"
    ),
    .testTarget(
      name: "UtilsTests",
      dependencies: [
        "Utils"
      ]
    ),
    .target(
      name: "SnapshotTestingUtils",
      dependencies: [
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing")

      ]
    ),
  ]
)
