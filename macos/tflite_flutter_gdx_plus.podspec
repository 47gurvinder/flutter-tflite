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

  s.source           = { :path => '.' }
  #s.source           = { :http => 'https://github.com/CaptainDario/DaKanji-Dependencies/releases/download/v3.0.0/libtensorflowlite_c-mac.dylib.zip' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'

  #s.vendored_libraries = 'libtensorflowlite_c-mac.dylib'
end
