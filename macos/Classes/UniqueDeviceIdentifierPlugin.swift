import Cocoa
import FlutterMacOS
import IOKit

public class UniqueDeviceIdentifierPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "unique_device_identifier", binaryMessenger: registrar.messenger)
    let instance = UniqueDeviceIdentifierPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "get_unique_identifier":
      if let uuid = fetchIOPlatformUUID() {
        result(uuid)
      } else {
        result(FlutterError(code: "UNAVAILABLE", message: "Unable to get device UUID", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func fetchIOPlatformUUID() -> String? {
    let port: mach_port_t

    if #available(macOS 12.0, *) {
      port = kIOMainPortDefault
    } else {
      port = kIOMasterPortDefault
    }

    let service = IOServiceGetMatchingService(port, IOServiceMatching("IOPlatformExpertDevice"))
    guard service != 0 else { return nil }

    defer { IOObjectRelease(service) }

    if let cfUuid = IORegistryEntryCreateCFProperty(service, "IOPlatformUUID" as CFString, kCFAllocatorDefault, 0)?
      .takeUnretainedValue() {
      return cfUuid as? String
    }

    return nil
  }
}
