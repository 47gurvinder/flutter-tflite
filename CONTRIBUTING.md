<!--
  Modified in 2026 for the community-maintained tflite_flutter_gdx_plus
  distribution.
-->

# Contributing to tflite_flutter_gdx_plus

Thank you for helping maintain this community continuation of TensorFlow's
`flutter-tflite` project.

## Before you start

- Search the [issue tracker](https://github.com/47gurvinder/flutter-tflite/issues)
  for an existing report or proposal.
- For a new capability, use the
  [feature request form](https://github.com/47gurvinder/flutter-tflite/issues/new?template=feature_request.yml).
- For a bug, include the Flutter and Dart versions, platform and OS version,
  device architecture, model details that can be shared, and a minimal
  reproduction.
- Keep changes focused. Discuss large API or native-library changes in an issue
  before investing substantial work.

## Development setup

Install a stable Flutter SDK compatible with Dart 3.3 or newer, then bootstrap
the repository:

```sh
dart pub global activate melos
melos bootstrap
```

Run the standard checks before submitting a Pull Request:

```sh
dart format --output=none --set-exit-if-changed .
flutter analyze .
flutter test
```

Run relevant example tests or builds for platform-specific changes. Several
examples require model downloads; follow the README in the example directory.

## Generated bindings

The FFI bindings in
`lib/src/bindings/tensorflow_lite_bindings_generated.dart` are generated. Do
not edit that file manually. When a TensorFlow Lite C header or binding config
changes, regenerate it with:

```sh
melos run ffigen
```

Include both the source change and regenerated output in the same Pull Request.

## Pull Requests

- Add or update tests for behavior changes and bug fixes.
- Update public API documentation when an API changes.
- Add only actual user-visible changes to `CHANGELOG.md`.
- Preserve all copyright, license, NOTICE, and third-party attribution.
- Add an appropriate license header to new source files.
- Do not include generated build artifacts, credentials, proprietary models,
  or data you do not have permission to redistribute.
- Open Pull Requests at
  <https://github.com/47gurvinder/flutter-tflite/pulls>.

## Licensing contributions

This repository is distributed primarily under the Apache License 2.0, with
inherited third-party terms identified in `THIRD_PARTY_NOTICES`. By submitting
a contribution, you represent that you have the right to submit it and agree
that it may be distributed under the applicable project license.

The original TensorFlow repository used Google's contribution processes. This
community-maintained fork is administered independently; do not send
agreements or conduct reports to former upstream maintainers.
