// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "YourProject",
  platforms: [.iOS(.v17), .macOS(.v14)],
  products: [
    .library(
      name: "YourProject",
      targets: ["YourProject"])
  ], dependencies: [
    .package(url: "https://github.com/nthState/CurtainRaiser", branch: "master")
  ],
  targets: [
    .target(
      name: "YourProject"),
    .testTarget(
      name: "YourProjectTests",
      dependencies: ["YourProject"])
  ]
)
