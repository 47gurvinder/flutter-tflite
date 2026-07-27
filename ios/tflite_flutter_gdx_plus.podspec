# Modified 2026 for the tflite_flutter_gdx_plus distribution.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tflite_flutter_gdx_plus.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tflite_flutter_gdx_plus'
  s.version          = '0.12.2'
  s.summary          = 'Community-maintained TensorFlow Lite plugin for Flutter.'
  s.description      = <<-DESC
Fast Dart FFI access to TensorFlow Lite for Flutter applications.
                       DESC
  s.homepage         = 'https://gurwinderdevx.com/'
  s.license          = { :file => '../LICENSE' }
  s.authors          = {
    'Gurwinder Singh' => 'contact@gurwinderdevx.com',
    'Original authors and contributors' => 'https://github.com/dropout/flutter-tflite'
  }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  # s.source_files = 'Classes/**/*'
  
  s.dependency 'Flutter'
  
  tflite_version = '2.12.0'
  s.dependency 'TensorFlowLiteSwift', tflite_version
  s.dependency 'TensorFlowLiteSwift/Metal', tflite_version
  s.dependency 'TensorFlowLiteSwift/CoreML', tflite_version

  s.platform = :ios, '11.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
