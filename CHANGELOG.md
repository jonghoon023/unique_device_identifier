# Changelog

All notable changes to this project will be documented in this file.

## 2.0.3

- Fixed incorrect usage example in documentation.

## 2.0.2

- Fixed version example in `README.md` to match the latest release.

## 2.0.1

- Added detailed doc comments to `getUniqueIdentifier()` to describe platform-specific behavior.
- No code changes; this is a documentation-only update.

## 2.0.0

- **Breaking Change**: `getUniqueIdentifier()` has been converted to a `static` method.
  - You can now call it directly without creating an instance:
    ```dart
    final deviceId = await UniqueDeviceIdentifier.getUniqueIdentifier();
    ```
  - This change simplifies usage but **breaks compatibility** with the previous instance-based approach:
    ```dart
    // ❌ This will no longer work:
    final deviceId = await UniqueDeviceIdentifier().getUniqueIdentifier();
    ```

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
