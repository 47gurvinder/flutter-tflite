import Cocoa
import FlutterMacOS
import TensorFlowLiteC

public class TfliteFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // Keep the dynamic runtime linked and loaded for Dart FFI lookups.
    _ = TfLiteVersion()

    let channel = FlutterMethodChannel(
      name: "tflite_flutter",
      binaryMessenger: registrar.messenger
    )
    let instance = TfliteFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
