// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "tflite_flutter_gdx_plus",
  platforms: [
    .iOS("13.0")
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
        "TensorFlowLiteCCoreML",
        "TensorFlowLiteCMetal",
      ]
    ),
    .binaryTarget(
      name: "TensorFlowLiteC",
      url:
        "https://github.com/kewlbear/TensorFlowLiteC/releases/download/0.0.20231002/TensorFlowLiteC.xcframework.zip",
      checksum: "140813c1d36edebf643706de47027d652c4732f2a11eb6f3c6b78b7065ea8349"
    ),
    .binaryTarget(
      name: "TensorFlowLiteCCoreML",
      url:
        "https://github.com/kewlbear/TensorFlowLiteC/releases/download/0.0.20231002/TensorFlowLiteCCoreML.xcframework.zip",
      checksum: "5957e405b917eb534ff425ce98d74a882b771e725b3e690bdb592ceb51d74025"
    ),
    .binaryTarget(
      name: "TensorFlowLiteCMetal",
      url:
        "https://github.com/kewlbear/TensorFlowLiteC/releases/download/0.0.20231002/TensorFlowLiteCMetal.xcframework.zip",
      checksum: "837e1e5afd00b3f135338caf69ed440c61c8f3053bb638fab1891f79bb2928d6"
    ),
  ]
)
