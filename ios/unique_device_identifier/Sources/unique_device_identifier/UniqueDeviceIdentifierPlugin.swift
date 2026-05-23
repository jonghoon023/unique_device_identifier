import Flutter
import UIKit

public class UniqueDeviceIdentifierPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "unique_device_identifier", binaryMessenger: registrar.messenger())
    let instance = UniqueDeviceIdentifierPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "get_unique_identifier":
      let uiDevice = UIDevice.current;
      result(uiDevice.identifierForVendor?.uuidString);
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
