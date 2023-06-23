// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "AccordionShader",
  defaultLocalization: "en",
  platforms: [.iOS(.v17), .macOS(.v14)],
  products: [
    .library(
      name: "AccordionShader",
      targets: ["AccordionShader"])
  ],
  targets: [
    .target(
      name: "AccordionShader"),
    .testTarget(
      name: "AccordionShaderTests",
      dependencies: ["AccordionShader"])
  ]
)
