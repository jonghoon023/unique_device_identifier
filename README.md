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
  - Attempts to read a UUID from `window.localStorage`
  - If the value is missing or invalid, it tries to generate one based on browser fingerprint
  - If fingerprinting fails, generates a new UUID using Dart code (`generateUUID`)
  - The newly generated UUID is stored in `localStorage` for future reuse
  - Ensures the same UUID persists across reloads and sessions

---

## 🚀 Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  unique_device_identifier: ^2.0.4
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
| Web      | Attempts to read a UUID from localStorage. If not found or invalid, it tries to generate one using a browser fingerprint. If that fails, it generates a new UUID using crypto.randomUUID. The newly generated UUID is then stored in localStorage for future reuse. |

---

## 🔒 Notes

- On **iOS and Android**, the UUID may change after uninstalling and reinstalling the app.
- macOS implementation avoids deprecated APIs on macOS 12+.
- On **Web**, the UUID is first read from `localStorage`. If it is missing or invalid, the plugin attempts to generate one using a browser fingerprint. If that fails, it falls back to a randomly generated UUID using Dart code. The final UUID is then stored in `localStorage` for future reuse and can be manually cleared by the user through the browser's storage settings.

---

## 🛠 Development

This plugin uses [MethodChannel](https://docs.flutter.dev/platform-integration/platform-channels) to communicate with native code.

Each platform implements `get_unique_identifier` using platform-specific APIs, and the Web implementation is written in Dart using `dart:js_interop`.

---

## 📄 License

MIT License
