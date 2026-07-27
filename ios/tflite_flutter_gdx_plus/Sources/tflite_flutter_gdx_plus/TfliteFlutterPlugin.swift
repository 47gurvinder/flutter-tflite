import Flutter
import TensorFlowLiteC
import TensorFlowLiteCCoreML
import TensorFlowLiteCMetal
import UIKit

public class TfliteFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // Keep the C runtime and delegate objects reachable for Dart FFI lookups.
    let ffiSymbols: [Any] = [
      TfLiteVersion,
      TfLiteCoreMlDelegateCreate,
      TfLiteCoreMlDelegateDelete,
      TFLGpuDelegateCreate,
      TFLGpuDelegateDelete,
    ]
    withExtendedLifetime(ffiSymbols) {}

    let channel = FlutterMethodChannel(
      name: "tflite_flutter",
      binaryMessenger: registrar.messenger()
    )
    let instance = TfliteFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
