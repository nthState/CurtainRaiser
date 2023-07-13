// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "CurtainRaiser",
  defaultLocalization: "en",
  platforms: [.iOS(.v17), .macOS(.v14), .visionOS(.v1)],
  products: [
    .library(
      name: "CurtainRaiser",
      targets: ["CurtainRaiser"])
  ],
  targets: [
    .target(
      name: "CurtainRaiser"),
    .testTarget(
      name: "CurtainRaiserTests",
      dependencies: ["CurtainRaiser"])
  ]
)
