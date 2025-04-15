# Changelog

All notable changes to this project will be documented in this file.

## 1.0.0

- Initial release of the `unique_device_identifier` Flutter plugin.
- Supports the following platforms:
  - ✅ Android (`Settings.Secure.ANDROID_ID`)
  - ✅ iOS (`UIDevice.identifierForVendor`)
  - ✅ Windows (`MachineGuid` from registry)
  - ✅ macOS (`IOPlatformUUID` via IOKit with macOS 12+ fallback)
  - ✅ Linux (`/etc/machine-id`)
  - ✅ Web (fingerprint-based hash with fallback to random UUID, stored in `localStorage`)
- No external dependencies required.
- Provides a consistent `getUniqueIdentifier()` interface for all platforms using `MethodChannel` and Dart interop.
