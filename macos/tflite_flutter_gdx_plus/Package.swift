// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "tflite_flutter_gdx_plus",
  platforms: [
    .macOS("13.0")
  ],
  products: [
    .library(
      name: "tflite-flutter-gdx-plus",
      targets: ["tflite_flutter_gdx_plus"]
    )
  ],
  dependencies: [
    .package(name: "FlutterFramework", path: "../FlutterFramework")
  ],
  targets: [
    .target(
      name: "tflite_flutter_gdx_plus",
      dependencies: [
        .product(
          name: "FlutterFramework",
          package: "FlutterFramework"
        ),
        "TensorFlowLiteC",
      ]
    ),
    .binaryTarget(
      name: "TensorFlowLiteC",
      path: "Frameworks/TensorFlowLiteC.xcframework"
    ),
  ]
)
