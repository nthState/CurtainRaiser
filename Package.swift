// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "AccordionShader",
  platforms: [.iOS(.v17), .macOS(.v14)],
  products: [
    .library(
      name: "AccordionShader",
      targets: ["AccordionShader"]),
  ],
  targets: [
    .target(
      name: "AccordionShader",
      swiftSettings: [
        .define("ENABLE_DEBUG", .when(configuration: .debug))
      ]),
    .testTarget(
      name: "AccordionShaderTests",
      dependencies: ["AccordionShader"]),
  ]
)
