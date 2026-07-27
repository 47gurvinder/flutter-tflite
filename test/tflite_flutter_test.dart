// Modified 2026 by Gurwinder Singh for the tflite_flutter_gdx_plus distribution.
import 'package:flutter_test/flutter_test.dart';
import 'package:tflite_flutter_gdx_plus/tflite_flutter_gdx_plus_platform_interface.dart';
import 'package:tflite_flutter_gdx_plus/tflite_flutter_gdx_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTfliteFlutterPlatform
    with MockPlatformInterfaceMixin
    implements TfliteFlutterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TfliteFlutterPlatform initialPlatform = TfliteFlutterPlatform.instance;

  test('$MethodChannelTfliteFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTfliteFlutter>());
  });

  test('getPlatformVersion', () async {
    TfliteFlutterPlatform.instance = MockTfliteFlutterPlatform();

    expect(await TfliteFlutterPlatform.instance.getPlatformVersion(), '42');
  });
}
