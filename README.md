<!--
  Modified in 2026 for the community-maintained tflite_flutter_gdx_plus
  distribution. Original project credits and licensing are preserved below.
-->

<p align="center">
  <img src="doc/tflite_flutter_cover.png"
       alt="TensorFlow Lite Flutter plugin cover" />
</p>

<p align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/platform-Flutter-02569B?logo=flutter"
         alt="Flutter platform" />
  </a>
  <a href="https://pub.dev/packages/tflite_flutter_gdx_plus">
    <img src="https://img.shields.io/pub/v/tflite_flutter_gdx_plus.svg"
         alt="Pub package version" />
  </a>
  <a href="https://pub.dev/documentation/tflite_flutter_gdx_plus/latest/">
    <img src="https://img.shields.io/badge/API-reference-blue"
         alt="API reference" />
  </a>
  <a href="https://github.com/47gurvinder/flutter-tflite/actions/workflows/flutter-ci.yml">
    <img src="https://github.com/47gurvinder/flutter-tflite/actions/workflows/flutter-ci.yml/badge.svg"
         alt="Flutter CI" />
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/license-Apache%202.0-blue.svg"
         alt="Apache 2.0 license" />
  </a>
</p>

# tflite_flutter_gdx_plus

A community-maintained Flutter plugin that provides a flexible, low-latency
Dart API for TensorFlow Lite inference. It binds directly to the TensorFlow
Lite C API through Dart FFI and follows the structure of the native Java and
Swift APIs.

The plugin supports CPU inference, multithreading, background-isolate
execution, and platform acceleration through NNAPI and GPU delegates on
Android, Metal and Core ML delegates on iOS, and XNNPACK on desktop.

## Features

- Run any compatible `.tflite` model from an asset, file, or byte buffer.
- Use single-input or multi-input/multi-output inference.
- Keep the UI responsive with `IsolateInterpreter`.
- Configure interpreter threads and hardware delegates.
- Target Android, iOS, Linux, macOS, and Windows.
- Use the included classification, detection, segmentation, pose, style
  transfer, super-resolution, question-answering, and reinforcement-learning
  examples.

## Compatibility

| Platform | Support | Notes |
| --- | --- | --- |
| Android | Supported | Current bundled native libraries require Android API 26 or newer at runtime. Android builds use LiteRT 1.4.0 and support 16 KB page sizes. |
| iOS | Supported | iOS 11 or newer. Test on a physical device; simulator support can vary. |
| macOS | Supported | A TensorFlow Lite C dynamic library must be supplied by the application. |
| Linux | Supported | A TensorFlow Lite C shared library must be supplied by the application. |
| Windows | Supported | A TensorFlow Lite C DLL must be supplied by the application. |
| Web | Not supported | This package uses native FFI libraries. |

The package requires Dart 3.3 or newer. Use a compatible stable Flutter SDK.

## Installation

Add the maintained package:

```sh
flutter pub add tflite_flutter_gdx_plus
```

Or add it directly to your application's `pubspec.yaml`:

```yaml
dependencies:
  tflite_flutter_gdx_plus: ^0.12.2
```

Then import the public library:

```dart
import 'package:tflite_flutter_gdx_plus/tflite_flutter_gdx_plus.dart';
```

## Platform setup

### Android

Android dependencies are downloaded by Gradle. Build and install on a
connected device:

```sh
flutter build apk
flutter install
```

The current native Android libraries require API level 26 or newer at runtime.

### iOS

iOS dependencies are downloaded by CocoaPods. Build and install from the
example application's directory:

```sh
flutter build ios
flutter install
```

TensorFlow Lite may not work in every iOS simulator configuration, so testing
on a physical device is recommended.

When creating an IPA, Xcode can strip symbols required by Dart FFI and report
`Failed to lookup symbol ... symbol not found`. In Xcode, open **Runner >
Build Settings > Strip Style** and change **All Symbols** to **Non-Global
Symbols**.

### macOS

Build `libtensorflowlite_c.dylib` by following the TensorFlow Lite
[Bazel build guide](https://www.tensorflow.org/lite/guide/build_arm) or
[CMake build guide](https://www.tensorflow.org/lite/guide/build_cmake).

For a universal library, build the required architectures and combine them:

```sh
lipo -create \
  arm64/libtensorflowlite_c.dylib \
  x86/libtensorflowlite_c.dylib \
  -output libtensorflowlite_c.dylib
```

Add the library to the application by following Flutter's
[macOS C interop guide](https://docs.flutter.dev/platform-integration/macos/c-interop#compiled-dynamic-library-macos).

### Linux

Build the TensorFlow Lite C `.so`, create a `blobs` directory at the
application root, and copy the library there as
`libtensorflowlite_c-linux.so`. Add this to the application's
`linux/CMakeLists.txt`:

```cmake
install(
  FILES ${PROJECT_BUILD_DIR}/../blobs/libtensorflowlite_c-linux.so
  DESTINATION ${INSTALL_BUNDLE_DATA_DIR}/../blobs/
)
```

### Windows

Build the TensorFlow Lite C DLL, create a `blobs` directory at the application
root, and copy the library there as `libtensorflowlite_c-win.dll`. Add this to
the application's `windows/CMakeLists.txt`:

```cmake
install(
  FILES ${PROJECT_BUILD_DIR}/../blobs/libtensorflowlite_c-win.dll
  DESTINATION ${INSTALL_BUNDLE_DATA_DIR}/../blobs/
)
```

## Usage

### Create an interpreter from an asset

Place the model in your application, declare it under `flutter.assets` in
`pubspec.yaml`, and load it:

```dart
final interpreter =
    await Interpreter.fromAsset('assets/your_model.tflite');
```

The API also supports creating an interpreter from a file or buffer. See the
[API reference](https://pub.dev/documentation/tflite_flutter_gdx_plus/latest/)
for the available constructors and options.

### Run inference

For one input and one output:

```dart
final input = [
  [1.23, 6.54, 7.81, 3.21, 2.22],
];
final output = List<double>.filled(2, 0).reshape([1, 2]);

interpreter.run(input, output);
print(output);
```

For multiple inputs and outputs:

```dart
final inputs = [
  [1.23],
  [2.43],
];
final outputs = <int, Object>{
  0: List<double>.filled(1, 0),
  1: List<double>.filled(1, 0),
};

interpreter.runForMultipleInputs(inputs, outputs);
print(outputs);
```

Always release native resources when inference is complete:

```dart
interpreter.close();
```

### Run inference in a background isolate

Create the regular interpreter, then wrap its native address:

```dart
final interpreter =
    await Interpreter.fromAsset('assets/your_model.tflite');
final isolateInterpreter =
    await IsolateInterpreter.create(address: interpreter.address);

await isolateInterpreter.run(input, output);
await isolateInterpreter.runForMultipleInputs(inputs, outputs);

await isolateInterpreter.close();
interpreter.close();
```

`IsolateInterpreter` performs inference away from the main isolate to avoid
blocking UI work.

## Examples

The [`example`](example) directory contains complete applications for:

- audio, digit, gesture, image, and text classification;
- BERT question answering;
- image segmentation and pose estimation;
- SSD MobileNet object detection;
- style transfer and ESRGAN super resolution;
- reinforcement learning.

Several examples download model files through their own `scripts` directory.
Read the example's README before building it.

## TFLite Flutter Helper Library

The former helper library is deprecated. For higher-level vision and media
tasks, evaluate [MediaPipe for Flutter](https://github.com/google/flutter-mediapipe).

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a change. This repository
uses [Melos](https://pub.dev/packages/melos):

```sh
dart pub global activate melos
melos bootstrap
flutter test
flutter analyze
```

FFI bindings are generated with [ffigen](https://pub.dev/packages/ffigen):

```sh
melos run ffigen
```

Do not hand-edit
`lib/src/bindings/tensorflow_lite_bindings_generated.dart`.

## Maintained Package

This package is community maintained because the upstream project is no longer
actively maintained. This repository continues
[`dropout/flutter-tflite`](https://github.com/dropout/flutter-tflite) and the
TensorFlow [`flutter-tflite`](https://github.com/tensorflow/flutter-tflite)
project on which it is based. TensorFlow's repository is itself a managed fork
of Amish Garg's original
[`tflite_flutter_plugin`](https://github.com/am15h/tflite_flutter_plugin).

Original project credits, copyright notices, contributor attribution, and
license terms remain intact. See [AUTHORS](AUTHORS), [NOTICE](NOTICE),
[THIRD_PARTY_NOTICES](THIRD_PARTY_NOTICES), the repository history, and
[LICENSE](LICENSE).

## Feature Requests

Feature requests and Pull Requests are always welcome.

- [Request a feature](https://github.com/47gurvinder/flutter-tflite/issues/new?template=feature_request.yml)
- [Report or review bugs](https://github.com/47gurvinder/flutter-tflite/issues)
- [Open or review Pull Requests](https://github.com/47gurvinder/flutter-tflite/pulls)

## License and acknowledgements

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).

The original authors and contributors are credited in [AUTHORS](AUTHORS).
Special thanks remain due to Amish Garg, the original author and Google Summer
of Code participant, and to the TensorFlow maintainers and all contributors
whose work forms the foundation of this package.

Inherited BSD-licensed source notices and terms are preserved in
[THIRD_PARTY_NOTICES](THIRD_PARTY_NOTICES).

## Need help or a custom solution?

Need help integrating this package, maintaining an existing project, or
building a custom web, mobile, or AI solution? Get in touch to discuss your
requirements:

- [Contact Gurwinder DevX](https://gurwinderdevx.com/)
- [Hire me on Upwork](https://www.upwork.com/freelancers/gurwinderdevx)

## Author and support

Maintained by **Gurwinder Singh**, a full-stack web and mobile application
developer and founder of [Gurwinder DevX](https://gurwinderdevx.com/).

- [GitHub](https://github.com/47gurvinder)
- [LinkedIn](https://www.linkedin.com/in/gurwinderdevx/)
- [Upwork](https://www.upwork.com/freelancers/gurwinderdevx)
- [Buy Me a Coffee](https://buymeacoffee.com/gurwinderdevx)

If this package helps your project, consider supporting its continued
development through Buy Me a Coffee.
