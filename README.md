# unique_device_identifier

A Flutter plugin that provides a unique device identifier on all platforms including **Android**, **iOS**, **Windows**, **macOS**, **Linux**, **Web**.

---

## ✨ Features

- 📱 Android: Uses `Settings.Secure.ANDROID_ID`
- 🍎 iOS: Uses `UIDevice.identifierForVendor`
- 💻 macOS: Uses `IOPlatformUUID` via IOKit
  - Automatically uses `kIOMainPortDefault` on macOS 12+ (no deprecation warning)
  - Falls back to `kIOMasterPortDefault` for compatibility with macOS 11 and earlier
- 🐧 Linux: Reads `/etc/machine-id`
- 🪟 Windows: Reads registry value `MachineGuid`
- 🌐 Web:
  - First attempts to read a stored UUID from `localStorage`
  - If not found, generates a fingerprint-based hash from browser characteristics
  - Falls back to a random UUID if fingerprinting fails
  - Stores the newly generated UUID in `localStorage` for future use

---

## 🚀 Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  unique_device_identifier: ^2.0.3
```

---

## ✅ Usage

```dart
import 'package:unique_device_identifier/unique_device_identifier.dart';

void main() async {
  final String? deviceId = await UniqueDeviceIdentifier.getUniqueIdentifier();
  print("Device ID: $deviceId");
}
```

---

## 📦 Supported Platforms

| Platform | Method |
|----------|--------|
| Android  | `Settings.Secure.ANDROID_ID` |
| iOS      | `UIDevice.identifierForVendor` |
| macOS    | `IOPlatformUUID` (via IOKit with macOS version fallback) |
| Linux    | `/etc/machine-id` |
| Windows  | Registry `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\MachineGuid` |
| Web      | Checks `localStorage` first, then generates fingerprint hash or random UUID |

---

## 🔒 Notes

- On **iOS and Android**, the UUID may change after uninstalling and reinstalling the app.
- On **Web**, UUID is stored in `localStorage` and may be cleared manually by the user.
- macOS implementation avoids deprecated APIs on macOS 12+.
- No external packages (like `uuid` or `device_info_plus`) are used.

---

## 🛠 Development

This plugin uses [MethodChannel](https://docs.flutter.dev/platform-integration/platform-channels) to communicate with native code.

Each platform implements `get_unique_identifier` using platform-specific APIs, and the Web implementation is written in Dart using `dart:js_interop`.

---

## 📄 License

MIT License
